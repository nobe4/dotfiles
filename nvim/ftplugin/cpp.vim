augroup cpp_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ clang-format -i $(VIM_FILEPATH) &&
				\ clang++ --config ./.clang --analyze $(VIM_FILEPATH)
	" autocmd BufWritePost <buffer> silent :!clang-format -i % && clang++ --config ./.clang --analyze %
augroup END
