require("conform").setup({
	format_on_save = {
		timeout_ms = 2500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		c = { "clang_format" },
		cpp = { "clang_format" },
		python = { "black" },
		go = { "gofmt", "goimports" },
		graphql = { "prettier" },
		javascript = { "prettier" },
		scss = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		-- TODO: add for yaml
		-- formatting.yamlfmt.with({
		-- 	extra_args = { "--formatter", "indentless_arrays=true,retain_line_breaks=true" },
		-- }),
	},
})
