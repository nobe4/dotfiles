-- Bootstrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[ packadd packer.nvim ]])
end

-- Compile on plugin change
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = "<afile>",
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Use a popup
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		compact = true,
		working_sym = ".",
		error_sym = "!",
		done_sym = "K",
		removed_syn = "X",
		moved_sym = "M",
	},
})

-- Configs are in after/plugin
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Packer can manage itself

	use("~/Documents/dev/helldb")

	-- Misc
	use("nobe4/exchange.vim")
	use("nobe4/curl.vim")
	use("nobe4/vimcorrect")
	use("tpope/vim-fugitive")
	-- use("tpope/vim-projectionist")
	use("tpope/vim-rhubarb")
	use("tpope/vim-sleuth")
	use("tpope/vim-surround")
	-- use("tpope/vim-scriptease")
	use("christoomey/vim-tmux-navigator")
	use("danro/rename.vim")
	use("editorconfig/editorconfig-vim")
	use("junegunn/vim-easy-align")
	use("mbbill/undotree")
	use("romainl/vim-qf")
	use("skywind3000/asyncrun.vim")
	use("mattn/emmet-vim")
	use("numToStr/Comment.nvim")
	use("habamax/vim-godot")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/playground")

	-- Snippet
	use("L3MON4D3/LuaSnip")

	-- LSP
	use("neovim/nvim-lspconfig")

	-- Mason
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Formatter
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy finder
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")

	-- https://github.com/TimUntersberger/neogit

	if packer_bootstrap then
		require("packer").sync()
	end
end)
