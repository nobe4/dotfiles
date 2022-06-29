set foldmethod=indent

augroup javascript_autocmd
	autocmd!
	autocmd BufWritePost * AsyncRun -strip
				\ prettier
				\ --loglevel=error
				\ --parser=babel
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
