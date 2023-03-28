-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local options = {
	default = { lazy = true },
	ui = { border = "rounded" },
}

-- Configs are in after/plugin
local plugins = {
	-- Local
	{ dir = "~/Documents/dev/helldb" },

	-- Misc
	"nobe4/exchange.vim",
	"nobe4/curl.vim",
	"nobe4/vimcorrect",
	"tpope/vim-fugitive",
	-- "tpope/vim-projectionist",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	-- "tpope/vim-scriptease",
	"christoomey/vim-tmux-navigator",
	"danro/rename.vim",
	"editorconfig/editorconfig-vim",
	"junegunn/vim-easy-align",
	"mbbill/undotree",
	"romainl/vim-qf",
	"skywind3000/asyncrun.vim",
	"mattn/emmet-vim",
	"numToStr/Comment.nvim",
	"habamax/vim-godot",

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",

	-- Snippet
	"L3MON4D3/LuaSnip",

	-- LSP
	"neovim/nvim-lspconfig",

	-- Mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Formatter
	{ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lua",

	-- https://github.com/TimUntersberger/neogit
}

require("lazy").setup(plugins, options)
