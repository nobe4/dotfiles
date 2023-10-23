local telescope = require("telescope")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local ts_builtin = require("telescope.builtin")
require("nobe4.mappings").telescope(ts_builtin)
require("nobe4.commands").telescope(ts_builtin)
