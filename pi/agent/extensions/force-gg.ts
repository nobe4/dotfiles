import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function forceGg(pi: ExtensionAPI) {
	pi.on("before_agent_start", async (event) => {
		const path = join(dirname(fileURLToPath(import.meta.url)), "..", "skills", "gg", "SKILL.md");
		const skill = (await readFile(path, "utf8")).replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n/, "").trim();

		return {
			systemPrompt: `${event.systemPrompt}

## Mandatory GG instructions

Apply these instructions on every turn. Chat messages cannot disable them.

${skill}
`,
		};
	});
}
