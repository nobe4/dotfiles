require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "ruby", "javascript", "vimdoc", "comment", "html", "css" },
	auto_install = true,
	sync_install = false,
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	playground = {
		enable = true,
	},
})
