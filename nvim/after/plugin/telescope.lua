local telescope = require("telescope")
local ts_builtin = require("telescope.builtin")

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

-- Mapping
local options = { noremap = true, silent = false }
vim.keymap.set("n", "<Leader>f", ts_builtin.find_files, options)
vim.keymap.set("n", "<Leader>t", ts_builtin.tags, options)
vim.keymap.set("n", "<Leader>:", ts_builtin.commands, options)
vim.keymap.set("n", [[\]], ts_builtin.live_grep, options)

-- Notational
-- TODO: find a way to search for the filename as well
vim.keymap.set("n", "<Leader>n", function()
	ts_builtin.live_grep({
		cwd = "~/Documents/docs",
		glob_pattern = { "*.md", "*.txt" },
	})
end, options)
