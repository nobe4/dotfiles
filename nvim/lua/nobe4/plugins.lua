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
	{ dir = "~/dev/nobe4/withhold.nvim" },
	{ dir = "~/dev/nobe4/relativity.nvim" },
	-- "nobe4/relativity.nvim",

	-- Misc
	"nobe4/exchange.vim",
	"nobe4/curl.vim",
	"nobe4/vimcorrect",

	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-surround",
	"github/copilot.vim",

	"stevearc/oil.nvim",
	"christoomey/vim-tmux-navigator",
	"danro/rename.vim",
	"editorconfig/editorconfig-vim",
	"junegunn/vim-easy-align",
	"mbbill/undotree",
	"romainl/vim-qf",
	"numToStr/Comment.nvim",
	-- "habamax/vim-godot",
	{ 'norcalli/nvim-colorizer.lua',              config = function() require 'colorizer'.setup() end },

	-- UI
	"nvim-tree/nvim-web-devicons",

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	-- "nvim-treesitter/nvim-treesitter-context",

	-- Snippet
	"L3MON4D3/LuaSnip",

	-- LSP
	"neovim/nvim-lspconfig",

	-- Mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Formatter
	"stevearc/conform.nvim",
	"folke/trouble.nvim",

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-telescope/telescope-ui-select.nvim",

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"saadparwaiz1/cmp_luasnip",

	-- Debugger
	"mfussenegger/nvim-dap",
	"leoluz/nvim-dap-go",
	"rcarriga/nvim-dap-ui",
}

require("lazy").setup(plugins, options)
