return {
	"mbbill/undotree",
	"danro/rename.vim",
	"romainl/vim-qf",
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				-- Text width + some buffer
				width = 85,
			},
		},
	},


	"nvim-tree/nvim-web-devicons",
	{ "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
	{ "hat0uma/csvview.nvim",        config = function() require("csvview").setup() end },
}
