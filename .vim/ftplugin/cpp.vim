" some people don't like auto-formatting
" \ clang-format -i $(VIM_FILEPATH) &&
augroup cpp_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ clang --config ./.clang --analyze $(VIM_FILEPATH)
augroup END
