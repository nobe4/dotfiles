vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteEnter",
	callback = require("nobe4.mappings").obsidian,
})

return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			require("obsidian").setup({
				legacy_commands = false,
				ui = {
					ignore_conceal_warn = true,
					bullets = { char = "-", hl_group = "ObsidianBullet" },
					hl_groups = {}, -- setup in mnml.lua
				},
				workspaces = {
					{
						name = "private",
						path = "~/dev/nobe4/dotfiles/private/notes/",
					},
				},
			})
		end,
	},
}
