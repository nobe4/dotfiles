return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		-- dependencies = { "nvim-treesitter/playground" },
		build = ":TSUpdate",

		config = function()
			local ts = require("nvim-treesitter")
			ts.install({
				"c", "cpp",
				"vim", "vimdoc",
				"lua", "ruby", "go",
				"html", "css", "javascript",
				"markdown",
				"markdown_inline",
				"comment",
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { '<filetype>' },
				callback = function()
					vim.treesitter.start()
					vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo[0][0].foldmethod = 'expr'
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				end,
			})
		end,
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("treesitter-context").setup({ separator = "-" })
	-- 	end,
	-- },
}
