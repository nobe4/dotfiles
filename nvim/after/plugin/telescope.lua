local telescope = require("telescope")
local ts_builtin = require("telescope.builtin")
local Mappings = require("nobe4.mappings")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
telescope.load_extension("fzf")

Mappings.telescope(ts_builtin)

vim.api.nvim_create_user_command("LSPReferences", ts_builtin.lsp_references, { bang = true })
