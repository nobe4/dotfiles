/**
 * Adds Copilot models that GitHub exposes before pi ships them.
 *
 * On startup, this extension fetches GitHub Copilot's `/models` endpoint,
 * filters models unavailable to the picker or tools, and appends only model IDs
 * missing from pi's built-in `github-copilot` provider. Built-in metadata,
 * transport, and OAuth remain unchanged.
 *
 * Authentication: COPILOT_GITHUB_TOKEN, GH_TOKEN, GITHUB_TOKEN, or
 * `gh auth token` (in that order). Run `gh auth login` if none is available.
 *
 * Configuration:
 *   PI_GITHUB_COPILOT_MODELS_BASE_URL  Override the discovery API base URL.
 *
 * Manual refresh: run `/reload` in pi. Restarting pi also refreshes, and
 * `pi --list-models github-copilot` fetches the latest list in a new process.
 *
 * Discovery is intentionally uncached and runs on every startup or `/reload`.
 * The request uses asynchronous I/O, but pi awaits this async extension factory
 * so the extra models are ready before startup completes. It is not detached
 * background work. A failed request only emits a warning; built-ins remain.
 */
import { spawnSync } from "node:child_process";
import type { ExtensionAPI, ProviderModelConfig } from "@earendil-works/pi-coding-agent";
import { getModels, type Api, type Model } from "@earendil-works/pi-ai";
import { githubCopilotOAuthProvider } from "@earendil-works/pi-ai/oauth";

const PROVIDER = "github-copilot" as const;
const BASE_URL = (process.env.PI_GITHUB_COPILOT_MODELS_BASE_URL || "https://api.enterprise.githubcopilot.com").replace(/\/$/, "");
const HEADERS = {
	"Accept": "application/json",
	"User-Agent": "GitHubCopilotChat/0.35.0",
	"Editor-Version": "vscode/1.107.0",
	"Editor-Plugin-Version": "copilot-chat/0.35.0",
	"Copilot-Integration-Id": "copilot-developer-cli",
	"X-GitHub-Api-Version": "2026-06-01",
};

type RawModel = Record<string, any>;

function token(): string | undefined {
	for (const name of ["COPILOT_GITHUB_TOKEN", "GH_TOKEN", "GITHUB_TOKEN"]) {
		if (process.env[name]?.trim()) return process.env[name]!.trim();
	}
	const result = spawnSync("gh", ["auth", "token"], { encoding: "utf8" });
	return result.status === 0 ? result.stdout.trim() || undefined : undefined;
}

function apiFor(model: RawModel): Api {
	const endpoints = model.supported_endpoints || [];
	if (endpoints.includes("/responses") || endpoints.includes("ws:/responses")) return "openai-responses";
	if (endpoints.includes("/v1/messages") || model.id.startsWith("claude-")) return "anthropic-messages";
	if (model.id.startsWith("gpt-5") || model.id.startsWith("oswe")) return "openai-responses";
	return "openai-completions";
}

function normalize(model: RawModel): ProviderModelConfig {
	const supports = model.capabilities?.supports || {};
	const limits = model.capabilities?.limits || {};
	const prices = model.billing?.token_prices?.default || {};
	const api = apiFor(model);
	const price = (value: unknown) => (typeof value === "number" ? value / 100 : 0);
	const limit = (value: unknown, fallback: number) =>
		typeof value === "number" && value > 0 ? value : fallback;

	return {
		id: model.id,
		name: model.name || model.id,
		api,
		reasoning: Boolean(
			supports.adaptive_thinking || supports.max_thinking_budget || supports.reasoning_effort?.length,
		),
		input: supports.vision ? ["text", "image"] : ["text"],
		cost: {
			input: price(prices.input_price),
			output: price(prices.output_price),
			cacheRead: price(prices.cache_price),
			cacheWrite: price(prices.cache_write_price),
		},
		contextWindow: limit(limits.max_context_window_tokens, limit(limits.max_prompt_tokens, 128000)),
		maxTokens: limit(limits.max_output_tokens, 8192),
		...(api === "openai-completions" && {
			compat: { supportsStore: false, supportsDeveloperRole: false, supportsReasoningEffort: false },
		}),
	};
}

export default async function (pi: ExtensionAPI): Promise<void> {
	const auth = token();
	if (!auth) {
		console.warn("[github-copilot-extra-models] Run `gh auth login` to discover extra models.");
		return;
	}

	try {
		const response = await fetch(`${BASE_URL}/models`, {
			headers: { ...HEADERS, Authorization: `Bearer ${auth}` },
		});
		if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);

		const payload = (await response.json()) as { data?: RawModel[] };
		const discovered = (payload.data || []).filter(
			(model) =>
				typeof model.id === "string" &&
				model.model_picker_enabled === true &&
				model.policy?.state !== "disabled" &&
				model.capabilities?.supports?.tool_calls !== false,
		);
		const builtIns = getModels(PROVIDER) as Model<Api>[];
		const builtInIds = new Set(builtIns.map((model) => model.id));
		const extraModels = discovered
			.filter((model) => !builtInIds.has(model.id))
			.map((model) => ({ ...normalize(model), headers: builtIns[0].headers }));

		if (!extraModels.length) return;
		pi.registerProvider(PROVIDER, {
			baseUrl: builtIns[0].baseUrl,
			oauth: githubCopilotOAuthProvider,
			models: [...builtIns.map(({ provider: _provider, ...model }) => model), ...extraModels],
		});
	} catch (error) {
		console.warn(`[github-copilot-extra-models] ${error instanceof Error ? error.message : String(error)}`);
	}
}
