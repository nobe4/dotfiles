local Mappings = require("nobe4.mappings")

-- TODO: have a telescope finder

-- Show diagnosis float text
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
	Mappings.lsp_mappings(bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_config = { on_attach = on_attach, capabilities = capabilities }

-- lspconfig.solargraph.setup(default_config)
lspconfig.clangd.setup(default_config)
lspconfig.gopls.setup(default_config)
lspconfig.marksman.setup(default_config)
lspconfig.pylsp.setup(default_config)
lspconfig.lua_ls.setup({
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

lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html" },
})
