setlocal foldmethod=indent

augroup vuejs_autocmd
	autocmd!
	autocmd BufWritePost *.vue silent AsyncRun! -strip
				\ prettier
				\ --loglevel=silent
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
