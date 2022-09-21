augroup c_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ clang-format -i $(VIM_FILEPATH)
augroup END
