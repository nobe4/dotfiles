return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		branch = 'main',
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		config = function()
			local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
			require('nvim-treesitter').install(parsers)
			vim.api.nvim_create_autocmd('FileType', {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then return end

					-- check if parser exists and load it
					if not vim.treesitter.language.add(language) then return end

					vim.treesitter.start(buf, language)
					vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo.foldmethod = 'expr'
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({ separator = "-" })
		end,
	}
}
