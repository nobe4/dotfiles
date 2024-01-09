local autocmd = vim.api.nvim_create_autocmd

-- Auto change the cwd in insert so C-X C-F works relative to the current file
autocmd("InsertEnter", { pattern = "*", command = [[let save_cwd = getcwd() | set autochdir]] })
autocmd("InsertLeave", { pattern = "*", command = [[set noautochdir | execute 'cd' fnameescape(save_cwd)]] })

-- Using Treesitter produces weird indentation on ., so just don't indent when
-- we press a .
-- See https://github.com/nvim-treesitter/nvim-treesitter/issues/3363#issuecomment-1229163192
autocmd("FileType", { pattern = "ruby", command = [[setlocal indentkeys-=.]] })

autocmd("QuickFixCmdPost", { pattern = "*", command = "botright copen 5" })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- autocmd("FocusGained", { pattern = "*", command = "redraw!" })

-- Update tmux
-- This causes issues, it doesn't seem to add much value as well
-- autocmd({
-- 	"BufReadPost",
-- 	"FileReadPost",
-- 	"BufNewFile",
-- }, { pattern = "*", command = [[call system("tmux rename-window 'vim:" . expand("%:t") . "'")]] })
-- autocmd("VimLeave", { pattern = "*", command = [[call system("tmux setw automatic-rename")]] })
