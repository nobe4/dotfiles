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
import { Editor, matchesKey, truncateToWidth, type EditorTheme } from "@earendil-works/pi-tui";

const allowListPath = join(dirname(fileURLToPath(import.meta.url)), "bash-allowlist.txt");

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

async function confirm(
	ctx: ExtensionContext,
	approval: { title: string; explanation: string },
): Promise<ConfirmationResult> {
	if (!ctx.hasUI) {
		return { block: true, reason: "Action needs confirmation, but no UI is available" };
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
						...renderEditor(
							editor,
							width,
							theme.fg("dim", " Enter: approve · type feedback: refine · no: deny"),
						),
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
	pi.on("tool_call", async (event, ctx) => {
		if (isToolCallEventType("bash", event)) {
			const command = event.input.command;
			let allowedCommands: string[];
			try {
				allowedCommands = (await readFile(allowListPath, "utf8"))
					.split(/\r?\n/)
					.map((command) => command.trim())
					.filter(Boolean);
			} catch (error) {
				const message = error instanceof Error ? error.message : String(error);
				return { block: true, reason: `Could not read bash allow list: ${message}` };
			}

			if (/^bundle exec rspec(?:\s|$)/.test(command)) {
				return confirm(ctx, {
					title: "Run this test command?",
					explanation: command,
				});
			}

			if (allowedCommands.includes(command)) return;
			return {
				block: true,
				reason:
					"Command execution is disabled. Do not call bash again. Give the user the exact command " +
					"and explain what it would do.",
			};
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
