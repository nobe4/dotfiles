require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		c = { "clang_format" },
		cpp = { "clang_format" },
		lua = { "stylua" },
		ruby = { "rubocop" },
		python = { "black" },
		golang = { "gofmt", "goimports" },
		javascript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		graphql = { "prettier" },
		json = { "prettier" },
		-- TODO: add for lua
		-- formatting.yamlfmt.with({
		-- 	extra_args = { "--formatter", "indentless_arrays=true,retain_line_breaks=true" },
		-- }),
	},
	formatters = {
		rubocop = {
			command = require("nobe4.tool.rubocop").command(),
		},
	},
})
