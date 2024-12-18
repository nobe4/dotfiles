require("obsidian").setup({
	ui = {
		ignore_conceal_warn = true,
		bullets = { char = "-", hl_group = "ObsidianBullet" },
		hl_groups = {}, -- setup in mnml.lua
		checkboxes = {
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			["!"] = { char = "", hl_group = "ObsidianImportant" },
		},
	},
	mappings = require("nobe4.mappings").obsidian,
	workspaces = {
		{
			name = "private",
			path = "~/dev/nobe4/dotfiles/private/notes/",
		},
	},
})
