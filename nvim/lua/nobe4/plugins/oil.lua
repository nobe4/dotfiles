return {
	"stevearc/oil.nvim",

	config = function()
		require("oil").setup({
			default_file_explorer = false,
			columns = {
				"mtime",
				"size",
				"icon",
			},
			delete_to_trash = false,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
			},
			view_options = {
				show_hidden = true,
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
