set foldmethod=indent

augroup html_autocmd
	autocmd!
	autocmd BufWritePost *.html silent AsyncRun! -strip
				\ prettier
				\ --loglevel=silent
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
