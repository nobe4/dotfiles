local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then return end

-- TODO: have a telescope finder
-- local map = vim.keymap.set

-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   map('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   map('n', 'gd', vim.lsp.buf.definition, bufopts)
--   map('n', 'K', vim.lsp.buf.hover, bufopts)
--   map('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--   map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   map('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts)
--   map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   map('n', 'gr', vim.lsp.buf.references, bufopts)
--   map('n', '<space>f', vim.lsp.buf.formatting, bufopts)
-- end
--
lspconfig.solargraph.setup({})
