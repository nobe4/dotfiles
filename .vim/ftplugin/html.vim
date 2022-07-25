set foldmethod=indent

augroup html_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ prettier
				\ --parser=html
				\ --loglevel=silent
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
