local autocmd = vim.api.nvim_create_autocmd

autocmd("InsertEnter", { pattern = "*", command = "set cursorline" })
autocmd("InsertLeave", { pattern = "*", command = "set nocursorline" })

-- Auto change the cwd in insert so C-X C-F works relative to the current file
autocmd("InsertEnter", { pattern = "*", command = [[let save_cwd = getcwd() | set autochdir]] })
autocmd("InsertLeave", { pattern = "*", command = [[set noautochdir | execute 'cd' fnameescape(save_cwd)]] })

autocmd("QuickFixCmdPost", { pattern = "*", command = "botright copen 5" })

autocmd("BufWritePre", { pattern = "*", command = [[exec 'norm m`' | %s/\s\+$//e | norm g``']] })
autocmd("FocusGained", { pattern = "*", command = "redraw!" })

-- Update tmux
autocmd({
	"BufReadPost",
	"FileReadPost",
	"BufNewFile",
}, { pattern = "*", command = [[call system("tmux rename-window 'vim:" . expand("%:t") . "'")]] })
autocmd("VimLeave", { pattern = "*", command = "call system('tmux setw automatic-rename')" })

--Install emmet
autocmd("FileType", { pattern = "html,css,less,eruby,jsp,jspf,htmldjango,vue,svelte", command = "EmmetInstall" })
