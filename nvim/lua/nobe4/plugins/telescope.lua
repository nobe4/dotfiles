return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",

					mappings = {
						i = {
							["<C-h>"] = actions.file_split,
							["<C-v>"] = actions.file_vsplit,
							["<C-t>"] = actions.file_tab,
						},
					},
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
		end,
	},
}
