set foldmethod=indent

augroup css_autocmd
	autocmd!
	autocmd BufWritePost * silent AsyncRun! -strip
				\ prettier
				\ --loglevel=error
				\ --parser css
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
