-- TODO: have a telescope finder

-- Show diagnosis float text
vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.diagnostic.config({
	float = { border = "single" },
	virtual_text = { prefix = "!" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.api.nvim_create_user_command("LspFix", function()
	vim.lsp.buf.code_action()
end, { bang = true })
vim.api.nvim_create_user_command("LspRename", function()
	vim.lsp.buf.rename()
end, { bang = true })

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	-- map('n', 'gD', vim.lsp.buf.declaration, bufopts)
	-- map('n', 'gd', vim.lsp.buf.definition, bufopts)
	-- map('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- map('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	-- map('n', 'gr', vim.lsp.buf.references, bufopts)
	-- map('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_config = { on_attach = on_attach, capabilities = capabilities }

lspconfig.solargraph.setup(default_config)
lspconfig.clangd.setup(default_config)
lspconfig.pylsp.setup(default_config)
lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require" } },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = { enable = false },
	},
})

lspconfig.gdscript.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
})
