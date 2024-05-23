local telescope = require("telescope")

telescope.setup({
	defaults = {
		preview = true,
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
telescope.load_extension("fzf")

local ts_builtin = require("telescope.builtin")
require("nobe4.mappings").telescope(ts_builtin)
require("nobe4.commands").telescope(ts_builtin)
