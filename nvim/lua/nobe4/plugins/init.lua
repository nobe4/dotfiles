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
    autocmd BufWritePost **/nobe4/plugins/*.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Use a popup
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
}

return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Packer can manage itself

  use("nobe4/exchange.vim")
  use("nobe4/curl.vim")
  use("nobe4/vimcorrect")

  use("tpope/vim-fugitive")
  use("tpope/vim-projectionist")
  use("tpope/vim-rhubarb")
  use("tpope/vim-sleuth")
  use("tpope/vim-surround")
  use("tpope/vim-scriptease")

  use("christoomey/vim-tmux-navigator")
  use("danro/rename.vim")
  use("editorconfig/editorconfig-vim")
  use("junegunn/vim-easy-align")
  use("mbbill/undotree")
  use("romainl/vim-qf")

  use(require("nobe4.plugins.luasnip"))
  use(require("nobe4.plugins.comment"))
  use(require("nobe4.plugins.telescope"))
  use(require("nobe4.plugins.lspconfig"))

  use("skywind3000/asyncrun.vim")
  vim.g.asyncrun_open = 0
  vim.g.asyncrun_trim = 1
  -- Auto open/close the quickfix window depending on the content.
  vim.g.asyncrun_exit = 'silent checktime | exec (len(getqflist())==0?"cclose":"copen 5")'


  -- https://github.com/TimUntersberger/neogit
  -- mattn/emmet-vim {
  -- Plug 'mattn/emmet-vim'
  -- let g:user_emmet_install_global = 0
  -- let g:user_emmet_leader_key=','
  -- autocmd FileType html,css,less,eruby,jsp,jspf,htmldjango,vue,svelte EmmetInstall
  -- }

  if packer_bootstrap then
    -- Automatically set up your configuration after cloning packer.nvim.
    -- Put this at the end after all plugins
    require("packer").sync()
  end
end)
