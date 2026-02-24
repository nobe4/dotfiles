local mappings = require("nobe4.mappings").lsp_mappings
local commands = require("nobe4.commands").lsp
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})


vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf

		-- Show diagnosis float text
		vim.diagnostic.config({
			virtual_text = {
				prefix = '.',
				virt_text_pos = 'right_align',
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		vim.api.nvim_buf_set_option(bufnr, "foldexpr", "v:lua.vim.lsp.foldexpr()")

		vim.lsp.inlay_hint.enable(true, { bufnr })

		mappings(bufnr)
		commands()
	end,
})

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	vim.lsp.enable(server_name)
end
