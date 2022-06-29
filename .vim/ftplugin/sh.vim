augroup sh_autocmd
	autocmd!
	autocmd BufWritePost * AsyncRun -strip
				\ shellcheck
				\ --shell=bash
				\ --format=gcc
				\ --color=never
				\ $(VIM_FILEPATH)
augroup END
