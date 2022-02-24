augroup sh_autocmd
	autocmd!
	autocmd BufWritePost <buffer> AsyncRun! -strip
				\ shellcheck
				\ --shell=bash
				\ --format=gcc
				\ --color=never
				\ $(VIM_FILEPATH)
augroup END
