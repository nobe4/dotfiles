set foldmethod=indent

augroup javascript_autocmd
	autocmd!
	autocmd BufWritePost *.js silent AsyncRun! -strip
				\ prettier
				\ --loglevel=silent
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
