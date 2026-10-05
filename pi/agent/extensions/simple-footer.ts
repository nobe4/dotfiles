import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

export default function simpleFooter(pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		ctx.ui.setFooter((_tui, theme, footerData) => ({
			invalidate() {},
			render(width: number): string[] {
				let cost = 0;

				for (const entry of ctx.sessionManager.getEntries()) {
					if (entry.type !== "message" || entry.message.role !== "assistant") continue;

					const message = entry.message as AssistantMessage;
					cost += message.usage.cost.total;
				}

				let path = ctx.sessionManager.getCwd();
				const home = process.env.HOME || process.env.USERPROFILE;
				if (home && path.startsWith(home)) path = `~${path.slice(home.length)}`;

				const model = ctx.model;
				const modelName = model
					? `${footerData.getAvailableProviderCount() > 1 ? `${model.provider}/` : ""}${model.id}`
					: "no-model";
				const info = [modelName];

				if (model?.reasoning) info.push(pi.getThinkingLevel());

				const usingSubscription = model && ctx.modelRegistry.isUsingOAuth(model);
				if (cost || usingSubscription) {
					info.push(`$${cost.toFixed(3)}${usingSubscription ? " (sub)" : ""}`);
				}

				const sessionName = ctx.sessionManager.getSessionName();
				if (sessionName) info.push(sessionName);
				for (const status of footerData.getExtensionStatuses().values()) {
					info.push(status.replace(/[\r\n\t]+/g, " ").trim());
				}

				const minimumPathWidth = Math.min(visibleWidth(path), Math.max(10, Math.floor(width / 3)));
				const right = truncateToWidth(info.join(" • "), Math.max(0, width - minimumPathWidth - 2), "");
				const rightWidth = visibleWidth(right);
				const gap = rightWidth ? 2 : 0;
				const left = truncateToWidth(path, Math.max(0, width - rightWidth - gap), "…");
				const padding = " ".repeat(Math.max(0, width - visibleWidth(left) - rightWidth));

				return [theme.fg("dim", `${left}${padding}${right}`)];
			},
		}));
	});
}
