" autocmd FileType go setlocal makeprg=goimports\ -l\ -w
" autocmd BufWritePost *.go silent make! <afile> | silent redraw!
" autocmd QuickFixCmdPost [^l]* cwindow

iabbrev ttt func Test(t *testing.T) {t.Skip("TODO")}<ESC>0f(i
iabbrev ttr t.Run("", func(t *testing.T) {t.Skip("TODO")})<ESC>0f"a
iabbrev forhook for _, e := range hook.Entries { t.Logf("=> %v", e) }
