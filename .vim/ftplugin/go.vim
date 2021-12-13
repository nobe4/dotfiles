" autocmd FileType go setlocal makeprg=goimports\ -l\ -w
" autocmd BufWritePost *.go silent make! <afile> | silent redraw!
" autocmd QuickFixCmdPost [^l]* cwindow

iabbrev ttt (t *testing.T)
iabbrev forhook for _, e := range hook.Entries { t.Logf("=> %v", e) }
