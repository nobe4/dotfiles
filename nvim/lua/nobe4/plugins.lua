-- Bootstrap
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Reload plugins on this file save
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Use a popup
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Packer can manage itself

  use "nobe4/exchange.vim"
  use "nobe4/curl.vim"
  use "nobe4/vimcorrect"

  use "tpope/vim-fugitive"
  use "tpope/vim-projectionist"
  use "tpope/vim-rhubarb"
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-scriptease"

  use "christoomey/vim-tmux-navigator"
  use "danro/rename.vim"
  use "editorconfig/editorconfig-vim"
  use "junegunn/vim-easy-align"
  use "mbbill/undotree"
  use "romainl/vim-qf"

  use {
    -- breaking changes listed here
    -- https://github.com/L3MON4D3/LuaSnip/issues/81
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    end
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>cc",
          block = "<leader>bc",
        },
        opleader = {
          line = "<Leader>c",
          block = "<Leader>b",
        }
      })
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use "skywind3000/asyncrun.vim"
  vim.g.asyncrun_open = 0
  vim.g.asyncrun_trim = 1
  -- Auto open/close the quickfix window depending on the content.
  vim.g.asyncrun_exit = 'silent checktime | exec (len(getqflist())==0?"cclose":"copen 5")'

  use "neovim/nvim-lspconfig"

  -- https://github.com/TimUntersberger/neogit
  -- mattn/emmet-vim {
  -- Plug 'mattn/emmet-vim'
  -- let g:user_emmet_install_global = 0
  -- let g:user_emmet_leader_key=','
  -- autocmd FileType html,css,less,eruby,jsp,jspf,htmldjango,vue,svelte EmmetInstall
  -- }

  -- Automatically set up your configuration after cloning packer.nvim.
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

