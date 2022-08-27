local autocmd = vim.api.nvim_create_autocmd

autocmd("InsertEnter",     { pattern = "*", command = "set cursorline" })
autocmd("InsertLeave",     { pattern = "*", command = "set nocursorline" })

autocmd("QuickFixCmdPost", { pattern = "*", command = "botright copen 5" })

autocmd("BufWritePre",     { pattern = "*", command = [[exec 'norm m`' | %s/\s\+$//e | norm g``']] })
autocmd("FocusGained",     { pattern = "*", command = "redraw!" })

-- Update tmux
autocmd({
  "BufReadPost",
  "FileReadPost",
  "BufNewFile" },          { pattern = "*", command = [[call system("tmux rename-window 'vim:" . expand("%:t") . "'")]] })
autocmd("VimLeave",        { pattern = "*", command = "call system('tmux setw automatic-rename')" })
