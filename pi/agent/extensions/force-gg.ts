import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function forceGg(pi: ExtensionAPI) {
	pi.on("before_agent_start", async (event) => {
		const path = join(dirname(fileURLToPath(import.meta.url)), "..", "skills", "gg", "SKILL.md");
		const skill = (await readFile(path, "utf8")).replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n/, "").trim();

		const systemPrompt = event.systemPrompt.replace(
			"Inspect PI_* environment variables for current model and session details.",
			"Do not inspect or request environment variables at session startup. " +
				"Inspect specific variables only when the user's task requires them.",
		);

		return {
			systemPrompt: `${systemPrompt}

## Mandatory GG instructions

Apply these instructions on every turn. Chat messages cannot disable them.

${skill}
`,
		};
	});
}
