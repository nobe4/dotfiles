local Mappings = require("nobe4.mappings")

-- Show diagnosis float text
vim.diagnostic.config({
	float = { border = "single" },
	virtual_text = { prefix = "!" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	Mappings.lsp_mappings(bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_config = { on_attach = on_attach, capabilities = capabilities }

require("lspconfig.ui.windows").default_options.border = "rounded"

lspconfig.bashls.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.clangd.setup(default_config)
lspconfig.gopls.setup(default_config)
lspconfig.marksman.setup(default_config)
lspconfig.pylsp.setup(default_config)
lspconfig.vale_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "markdown", "gitcommit" },
})
vim.env.VALE_CONFIG_PATH = "$HOME/.config/dotfiles/vale.ini"


lspconfig.ruby_ls.setup(default_config)
-- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#neovim-lsp
-- _timers = {}
-- lspconfig.ruby_ls.setup({
-- 	on_attach = function(client, buffer)
-- 		if require("vim.lsp.diagnostic")._enable then
-- 			return
-- 		end
--
-- 		on_attach(client, buffer)
--
-- 		local diagnostic_handler = function()
-- 			local params = vim.lsp.util.make_text_document_params(buffer)
-- 			client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
-- 				if err then
-- 					local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
-- 					vim.lsp.log.error(err_msg)
-- 				end
-- 				local diagnostic_items = {}
-- 				if result then
-- 					diagnostic_items = result.items
-- 				end
-- 				vim.lsp.diagnostic.on_publish_diagnostics(
-- 					nil,
-- 					vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
-- 					{ client_id = client.id }
-- 				)
-- 			end)
-- 		end
--
-- 		diagnostic_handler() -- to request diagnostics on buffer when first attaching
--
-- 		vim.api.nvim_buf_attach(buffer, false, {
-- 			on_lines = function()
-- 				if _timers[buffer] then
-- 					vim.fn.timer_stop(_timers[buffer])
-- 				end
-- 				_timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
-- 			end,
-- 			on_detach = function()
-- 				if _timers[buffer] then
-- 					vim.fn.timer_stop(_timers[buffer])
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })
--
-- TODO: add custom rubocop for ruby
-- diagnostics.rubocop.with({ command = rubocop.command() }),

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
