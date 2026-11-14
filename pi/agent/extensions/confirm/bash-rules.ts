import { appendFile, readFile } from "node:fs/promises";

export function parseCommandPatterns(contents: string): RegExp[] {
	return contents
		.split(/\r?\n/)
		.map((line) => line.trim())
		.filter((line) => line && !line.startsWith("#"))
		.map((source) => new RegExp(`^(?:${source})$`));
}

export function commandDecision(
	command: string,
	allowed: RegExp[],
	denied: RegExp[],
): "never" | "safe" | "confirm" {
	if (denied.some((pattern) => pattern.test(command))) return "never";
	if (allowed.some((pattern) => pattern.test(command))) return "safe";
	return "confirm";
}

export async function addDeniedCommand(path: string, command: string): Promise<void> {
	const contents = await readFile(path, "utf8");
	if (parseCommandPatterns(contents).some((pattern) => pattern.test(command))) return;

	const source = command.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
	const separator = contents && !contents.endsWith("\n") ? "\n" : "";
	await appendFile(path, `${separator}${source}\n`);
}
