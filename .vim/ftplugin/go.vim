iabbrev ttt func Test(t *testing.T) {t.Skip("TODO")}<ESC>0f(i
iabbrev ttr t.Run("", func(t *testing.T) {t.Skip("TODO")})<ESC>0f"a
iabbrev forhook for _, e := range hook.Entries { t.Logf("=> %v", e) }

augroup go_autocmd
	autocmd!
	" Fix with gofmt / goimports and then check with go vet.
	" grep/sed to make go vet output readable by vim
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ gofmt -w -s $(VIM_FILEPATH) &&
				\ goimports -w $(VIM_FILEPATH) &&
				\ go vet $(VIM_FILEDIR)/*.go 2>&1 | grep -v '^\#' | sed 's/vet: //'
augroup END
