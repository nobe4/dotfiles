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

-- Configs are in after/plugin
local plugins = {

}

require("lazy").setup(
	{
		spec = {
			{ import = "nobe4.plugins" },
			plugins,
		},
	},
	{
		default = { lazy = true },
		-- TODO: check if https://github.com/folke/lazy.nvim/issues/1951 is closed
		ui = {
			border = "rounded",
			custom_key = false,
		},
	}
)
