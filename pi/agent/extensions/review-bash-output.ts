import {
	createLocalBashOperations,
	type ExtensionAPI,
	type ExtensionContext,
} from "@earendil-works/pi-coding-agent";

const reviewRequest = "Paste the output here for review.";

function outputWasRequested(ctx: ExtensionContext): boolean {
	for (const entry of ctx.sessionManager.getBranch().toReversed()) {
		if (entry.type !== "message" || entry.message.role !== "assistant") continue;
		return entry.message.content.some(
			(block) => block.type === "text" && block.text.includes(reviewRequest),
		);
	}
	return false;
}

export default function reviewBashOutput(pi: ExtensionAPI) {
	pi.on("user_bash", (event, ctx) => {
		if (event.excludeFromContext || !outputWasRequested(ctx)) return;

		const local = createLocalBashOperations({ shellPath: pi.getSettings().shellPath });
		return {
			operations: {
				async exec(command, cwd, options) {
					const result = await local.exec(command, cwd, options);
					setTimeout(() => {
						pi.sendUserMessage("Review the command output above.", {
							deliverAs: "followUp",
						});
					}, 0);
					return result;
				},
			},
		};
	});
}
