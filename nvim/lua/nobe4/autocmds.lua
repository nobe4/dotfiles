vim.cmd [[
  autocmd InsertEnter * set cursorline
  autocmd InsertLeave * set nocursorline

  " Open cwindow automatically if there are items in it
  " autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost * botright copen 5

  autocmd BufWritePre * :exec 'norm m`' | %s/\s\+$//e | norm g``'

  autocmd! BufWritePost espanso_config.yml !espanso restart&

  autocmd! FocusGained * :redraw!

  autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window 'vim:" . expand("%:t") . "'")
  autocmd VimLeave * call system("tmux setw automatic-rename")

  autocmd! GUIEnter * set vb t_vb=
]]

