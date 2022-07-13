" some people don't like auto-formatting
" augroup cpp_autocmd
	" autocmd!
	" autocmd BufWritePost <buffer> silent AsyncRun! -strip
				" \ clang-format -i $(VIM_FILEPATH) &&
				" \ clang --config ./.clang --analyze $(VIM_FILEPATH)
" augroup END
