return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 2500,
				lsp_fallback = true,
			},

			formatters_by_ft = {
				nix = { "nixfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				arduino = { "clang_format" },
				python = { "black" },
				go = { "gofmt", "goimports" },
				graphql = { "prettier" },
				javascript = { "prettier" },
				scss = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
			},
		})
	end,
}
