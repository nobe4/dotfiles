set foldmethod=indent

augroup css_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ prettier
				\ --loglevel=error
				\ --parser css
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
