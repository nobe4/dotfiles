local augroup = vim.api.nvim_create_augroup("null_ls_formatting", {})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- c/c++
		null_ls.builtins.formatting.clang_format,

		-- lua
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.selene,

		-- ruby
		null_ls.builtins.diagnostics.rubocop,
		-- null_ls.builtins.formatting.rubocop,

		-- python
		null_ls.builtins.formatting.black,

		-- golang
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,

		-- general prose
		null_ls.builtins.diagnostics.vale,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
