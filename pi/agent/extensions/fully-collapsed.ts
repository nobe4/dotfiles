import type { ExtensionAPI, ToolDefinition } from "@earendil-works/pi-coding-agent";
import {
	createBashToolDefinition,
	createEditToolDefinition,
	createFindToolDefinition,
	createGrepToolDefinition,
	createLsToolDefinition,
	createReadToolDefinition,
	createWriteToolDefinition,
} from "@earendil-works/pi-coding-agent";
import { Container, Text } from "@earendil-works/pi-tui";
import type { Static, TSchema } from "typebox";

function fullyCollapsible<TParams extends TSchema, TDetails, TState>(
	definition: ToolDefinition<TParams, TDetails, TState>,
	collapseArgs?: (args: Static<TParams>) => Static<TParams>,
): ToolDefinition<TParams, TDetails, TState> {
	const renderCall = definition.renderCall;
	const renderResult = definition.renderResult;

	return {
		...definition,
		renderShell: "self",
		renderCall: renderCall
			? (args, theme, context) =>
					renderCall(
						!context.expanded && collapseArgs ? collapseArgs(args) : args,
						theme,
						context,
					)
			: undefined,
		renderResult(result, options, theme, context) {
			if (!options.expanded || !renderResult) return new Container();
			return renderResult(result, options, theme, context);
		},
	};
}

export default function fullyCollapsed(pi: ExtensionAPI) {
	const cwd = process.cwd();

	pi.registerTool(fullyCollapsible(createReadToolDefinition(cwd)));
	pi.registerTool(fullyCollapsible(createBashToolDefinition(cwd)));
	const edit = fullyCollapsible(
		createEditToolDefinition(cwd),
		(args) => ({ ...args, edits: [] }),
	);
	const renderEditCall = edit.renderCall;
	edit.renderCall = (args, theme, context) => {
		if (context.expanded && renderEditCall) return renderEditCall(args, theme, context);
		const title = theme.fg("toolTitle", theme.bold("edit"));
		const path = theme.fg("accent", args.path || "...");
		return new Text(`${title} ${path}`, 0, 0);
	};
	pi.registerTool(edit);
	pi.registerTool(
		fullyCollapsible(createWriteToolDefinition(cwd), (args) => ({ ...args, content: "" })),
	);
	pi.registerTool(fullyCollapsible(createGrepToolDefinition(cwd)));
	pi.registerTool(fullyCollapsible(createFindToolDefinition(cwd)));
	pi.registerTool(fullyCollapsible(createLsToolDefinition(cwd)));

	pi.on("session_start", (_event, ctx) => {
		ctx.ui.setHiddenThinkingLabel("");
	});
}
