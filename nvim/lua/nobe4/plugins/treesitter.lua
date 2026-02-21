return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/playground" },
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c", "cpp",
					"vim", "vimdoc",
					"lua", "ruby", "go",
					"html", "css", "javascript",
					"markdown",
					"markdown_inline",
					"comment",
				},

				auto_install = true,
				sync_install = false,

				indent = { enable = true },

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				playground = { enable = true },

				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({ separator = "-" })
		end,
	},
}
