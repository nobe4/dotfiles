set foldmethod=indent

augroup scss_autocmd
	autocmd!
	autocmd BufWritePost *.scss silent AsyncRun! -strip
				\ prettier
				\ --loglevel=silent
				\ -w --no-color
				\ $(VIM_FILEPATH)
augroup END
