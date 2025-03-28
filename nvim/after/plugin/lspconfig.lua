local Mappings = require("nobe4.mappings")

-- Show diagnosis float text
vim.diagnostic.config({
	virtual_lines = true,
	float = { border = "single" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.lsp.inlay_hint.enable(true, { bufnr })
	Mappings.lsp_mappings(bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()
local default_config = { on_attach = on_attach, capabilities = capabilities }

require("lspconfig.ui.windows").default_options.border = "rounded"

lspconfig.bashls.setup(default_config)
lspconfig.clangd.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.pylsp.setup(default_config)
lspconfig.ts_ls.setup(default_config)
lspconfig.yamlls.setup(default_config)

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				shadow = true,
				unusedvariable = true,
				useany = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		}
	},
})
lspconfig.golangci_lint_ls.setup(default_config)
lspconfig.marksman.setup(default_config)
lspconfig.pylsp.setup(default_config)
lspconfig.vale_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "markdown", "gitcommit" },
})

-- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#neovim-lsp
lspconfig.ruby_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		formatter = "rubocop",
		linters = { "rubocop" },
		enabledFeatures = {
			codeActions = true,
			codeLens = true,
			completion = true,
			definition = true,
			diagnostics = true,
			documentHighlights = true,
			documentLink = true,
			documentSymbols = true,
			foldingRanges = true,
			formatting = true,
			hover = true,
			inlayHint = true,
			onTypeFormatting = true,
			selectionRanges = true,
			semanticHighlighting = true,
			signatureHelp = true,
			typeHierarchy = true,
			workspaceSymbol = true
		},
		featuresConfiguration = {
			inlayHint = {
				implicitHashValue = true,
				implicitRescue = true
			}
		},
	},
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require", "hs", "spoon" } },
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
