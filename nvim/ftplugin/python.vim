iabbrev ;debug; import pdb; pdb.set_trace()
set foldmethod=indent

augroup python_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun -strip
				\ black -q $(VIM_FILEPATH)
augroup END

