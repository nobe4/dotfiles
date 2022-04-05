set foldmethod=indent

augroup svelte_autocmd
	autocmd!
	autocmd BufWritePost *.svelte silent AsyncRun! -strip
				\ prettier
				\ --loglevel=silent
				\ --plugin-search-dir=.
				\ --plugin-search-dir=./web
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END

