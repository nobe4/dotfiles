" Ruby foldmethod is slow with the regexengine 0
setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10
iabbrev ;debug; require "pry"; binding.pry
iabbrev ;pry; require "pry"; binding.pry
iabbrev debug; require "pry"; binding.pry
iabbrev pry; require "pry"; binding.pry

nnoremap <leader>m :execute 'split term://bundle exec rspec --fail-fast %\:' . (line(".") + 1)<CR>

augroup ruby_autocmd
	autocmd! * <buffer>

	" grep -v hides rubocop enthusiastic correction messages
	" { ... || true; } is needed because grep will exit 1 if there's no match.
	autocmd BufWritePost <buffer> silent AsyncRun! -strip
				\ $HOME/.rbenv/shims/bundle exec rubocop
				\ --format emacs -a -A
				\ $(VIM_FILEPATH)
				\ | { grep -v 'Corrected' || true; }
augroup END
