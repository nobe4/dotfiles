require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "ruby", "javascript", "help", "comment" },
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	playground = {
		enable = true,
	},
})
