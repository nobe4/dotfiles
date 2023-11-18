local augroup = vim.api.nvim_create_augroup("null_ls_formatting", {})

local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local rubocop = require("nobe4.tool.rubocop")

local sources = {
	-- c/c++
	formatting.clang_format,

	-- lua
	formatting.stylua,
	diagnostics.selene,

	-- ruby
	diagnostics.rubocop.with({ command = rubocop.command() }),
	formatting.rubocop.with({ command = rubocop.command() }),

	-- python
	formatting.black,

	-- golang
	diagnostics.golangci_lint,
	formatting.gofmt,
	formatting.goimports,

	-- general prose
	diagnostics.vale,

	-- shell
	diagnostics.shellcheck,

	-- yaml
	formatting.yamlfmt.with({
		extra_args = { "--formatter", "indentless_arrays=true,retain_line_breaks=true" },
	}),

	-- multipurpose
	formatting.prettier.with({
		disabled_filetypes = { "markdown", "yaml" },
	}),
}

null_ls.setup({
	debug = true,
	sources = sources,
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
