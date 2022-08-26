set foldmethod=indent

augroup svelte_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ prettier
				\ --loglevel=error
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END

