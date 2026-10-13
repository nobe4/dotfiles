return {
	"mbbill/undotree",
	"danro/rename.vim",
	"romainl/vim-qf",
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				-- Text width + some buffer
				width = 100,
			},
		},
	},


	"nvim-tree/nvim-web-devicons",
	{
		"gzitei/paint.nvim",
		ft = { "css", "scss", "sass", "less", "stylus", "python" },
		opts = {},
	},

	{ "hat0uma/csvview.nvim", config = function() require("csvview").setup() end },
}
