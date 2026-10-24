import { constants } from "node:fs";
import { access, readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import {
	createEditToolDefinition,
	isToolCallEventType,
	type EditToolCallEvent,
	type ExtensionAPI,
	type ExtensionContext,
	type ToolCallEvent,
	type WriteToolCallEvent,
} from "@earendil-works/pi-coding-agent";
import { Editor, matchesKey, Text, truncateToWidth, type EditorTheme } from "@earendil-works/pi-tui";

const allowListPath = join(dirname(fileURLToPath(import.meta.url)), "bash-allowlist.txt");
const shellComposition = /[;&|`\n\r]|\$\(|[<>]\(/;

function parseAllowedCommands(contents: string): RegExp[] {
	return contents
		.split(/\r?\n/)
		.map((line) => line.trim())
		.filter((line) => line && !line.startsWith("#"))
		.map((source) => new RegExp(`^(?:${source})$`));
}

function getEditExplanation(ctx: ExtensionContext, toolCallId: string): string {
	for (const entry of ctx.sessionManager.getBranch().toReversed()) {
		if (entry.type !== "message" || entry.message.role !== "assistant") continue;

		let explanation = "";
		for (const content of entry.message.content) {
			if (content.type === "text" && content.text.trim()) {
				const paragraphs = content.text.trim().split(/\n\s*\n/);
				explanation = paragraphs.at(-1)?.replace(/\s+/g, " ") ?? "";
			}
			if (content.type === "toolCall" && content.id === toolCallId) return explanation;
		}
	}
	return "";
}

type ConfirmationResult = { block: true; reason: string } | undefined;

const denial = new RegExp( "^(?:n|no|nope|negative|deny|decline|reject|cancel|stop|abort|forbid|forbidden|never|don['’]t|wtf)$", "i");
const waitingWidget = "confirmation-waiting";

function applyResponse(response: string): ConfirmationResult {
	const value = response.trim();
	if (!value) return;
	if (denial.test(value)) return { block: true, reason: "Blocked by user" };
	return { block: true, reason: `User requested refinement:\n${value}` };
}

function renderEditor(editor: Editor, width: number, placeholder: string): string[] {
	const lines = editor.render(width);
	if (editor.getText() || lines.length < 3) return lines;
	lines[1] = truncateToWidth(`${lines[1]?.trimEnd() ?? ""}${placeholder}`, width, "");
	return lines;
}

async function waitForEmptyEditor(ctx: ExtensionContext): Promise<boolean> {
	if (!ctx.ui.getEditorText()) return true;

	ctx.ui.setWidget(waitingWidget, (_tui, theme) =>
		new Text(theme.fg("dim", "Review waiting. Submit or clear your draft."), 1, 0),
	);
	try {
		while (ctx.ui.getEditorText()) {
			if (ctx.signal?.aborted) return false;
			await new Promise((resolve) => setTimeout(resolve, 100));
		}
		return true;
	} finally {
		ctx.ui.setWidget(waitingWidget, undefined);
	}
}

async function confirm(
	ctx: ExtensionContext,
	approval: {
		title: string;
		explanation: string;
		onSafe?: () => void | Promise<void>;
	},
): Promise<ConfirmationResult> {
	if (!ctx.hasUI) {
		return { block: true, reason: "Action needs confirmation, but no UI is available" };
	}

	if (!(await waitForEmptyEditor(ctx))) {
		return { block: true, reason: "Session ended before confirmation" };
	}

	const toolsExpanded = ctx.ui.getToolsExpanded();
	ctx.ui.setToolsExpanded(true);

	try {
		const response = await ctx.ui.custom<string>((tui, theme, _keybindings, done) => {
			const editorTheme: EditorTheme = {
				borderColor: (text) => theme.fg("borderAccent", text),
				selectList: {
					selectedPrefix: (text) => theme.fg("accent", text),
					selectedText: (text) => theme.fg("accent", text),
					description: (text) => theme.fg("muted", text),
					scrollInfo: (text) => theme.fg("dim", text),
					noMatch: (text) => theme.fg("warning", text),
				},
			};
			const editor = new Editor(tui, editorTheme);
			editor.onSubmit = done;
			const actions = approval.onSafe
				? ' Enter: approve · type "safe": approve and update regex · type feedback: refine · no: deny'
				: " Enter: approve · type feedback: refine · no: deny";

			return {
				get focused() {
					return editor.focused;
				},
				set focused(value: boolean) {
					editor.focused = value;
				},
				render(width: number): string[] {
					return [
						theme.fg("toolTitle", theme.bold(approval.title)),
						truncateToWidth(theme.fg("text", approval.explanation), width, "…"),
						"",
						...renderEditor(editor, width, theme.fg("dim", actions)),
					];
				},
				invalidate() {
					editor.invalidate();
				},
				handleInput(data: string) {
					if (matchesKey(data, "ctrl+c")) done("no");
					else editor.handleInput(data);
				},
			};
		});

		if (approval.onSafe && response.trim() === "safe") {
			try {
				await approval.onSafe();
				return;
			} catch (error) {
				const message = error instanceof Error ? error.message : String(error);
				return { block: true, reason: `Could not request bash allow-list update: ${message}` };
			}
		}

		return applyResponse(response);
	} finally {
		ctx.ui.setToolsExpanded(toolsExpanded);
	}
}

async function confirmFileTool<TEvent extends ToolCallEvent>(
	event: ToolCallEvent,
	ctx: ExtensionContext,
	config: {
		matches(event: ToolCallEvent): event is TEvent;
		preflight?(
			ctx: ExtensionContext,
			toolCallId: string,
			input: TEvent["input"],
		): Promise<void>;
	},
): Promise<ConfirmationResult> {
	if (!config.matches(event)) return;

	const explanation = getEditExplanation(ctx, event.toolCallId);
	if (!explanation) {
		return {
			block: true,
			reason: `Explain the ${event.toolName} before requesting approval`,
		};
	}

	try {
		await config.preflight?.(ctx, event.toolCallId, event.input);
	} catch (error) {
		const message = error instanceof Error ? error.message : String(error);
		return { block: true, reason: `${event.toolName} preflight failed: ${message}` };
	}

	return confirm(ctx, {
		title: `Apply this ${event.toolName}?`,
		explanation,
	});
}

export default function requireConfirmation(pi: ExtensionAPI) {
	const safeCommands = new Set<string>();

	pi.on("turn_end", () => {
		if (!safeCommands.size) return;

		const commands = [...safeCommands];
		safeCommands.clear();
		pi.sendUserMessage(
			`Make the smallest JavaScript regex update in ${allowListPath} that authorizes ` +
				`these commands: ${JSON.stringify(commands)}. Prefer widening each command's ` +
				"existing pattern. Keep one flat, repeatable alternation of allowed flags per " +
				"command. Each flag must work independently and in any order. Keep required " +
				"values with their flags. Preserve current command and flag restrictions. Do not " +
				"append any exact command as a regex line. Edit the file now.",
			{ deliverAs: "followUp" },
		);
	});

	pi.on("tool_call", async (event, ctx) => {
		if (isToolCallEventType("bash", event)) {
			const command = event.input.command.trim();
			if (shellComposition.test(command)) {
				return {
					block: true,
					reason: "Run one command per bash call so each command can be approved separately",
				};
			}

			let allowedCommands: RegExp[];
			try {
				allowedCommands = parseAllowedCommands(await readFile(allowListPath, "utf8"));
			} catch (error) {
				const message = error instanceof Error ? error.message : String(error);
				return { block: true, reason: `Could not read bash allow list: ${message}` };
			}

			if (allowedCommands.some((pattern) => pattern.test(command))) return;

			return confirm(ctx, {
				title: "Run this command?",
				explanation: command,
				onSafe: () => {
					safeCommands.add(command);
				},
			});
		}

		const editResult = await confirmFileTool<EditToolCallEvent>(event, ctx, {
			matches: (event) => isToolCallEventType("edit", event),
			async preflight(ctx, toolCallId, input) {
				const definition = createEditToolDefinition(ctx.cwd, {
					operations: {
						access: (path) => access(path, constants.R_OK | constants.W_OK),
						readFile,
						writeFile: () => Promise.resolve(),
					},
				});
				await definition.execute(toolCallId, input, ctx.signal, undefined, ctx);
			},
		});
		if (editResult) return editResult;

		return confirmFileTool<WriteToolCallEvent>(event, ctx, {
			matches: (event) => isToolCallEventType("write", event),
		});
	});
}
