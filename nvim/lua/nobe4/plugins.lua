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
	pattern = vim.fn.expand("**/nobe4/plugins/*.lua"),
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
	},
})

-- Configs are in after/plugin
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Packer can manage itself

	-- nobe4
	use("~/Documents/dev/helldb")
	use("nobe4/exchange.vim")
	use("nobe4/curl.vim")
	use("nobe4/vimcorrect")

	-- tpope
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
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/playground")
	use("numToStr/Comment.nvim")
	use("neovim/nvim-lspconfig")
	use("L3MON4D3/LuaSnip")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("skywind3000/asyncrun.vim")
	use("mattn/emmet-vim")

	-- https://github.com/TimUntersberger/neogit

	if packer_bootstrap then
		require("packer").sync()
	end
end)
