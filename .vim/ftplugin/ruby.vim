" Ruby foldmethod is slow with the regexengine 0
setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10
iabbrev ;debug; require "pry"; binding.pry

augroup ruby_autocmd
	autocmd!

	" grep -v hides rubocop enthusiastic correction messages
	" { ... || true; } is needed because grep will exit 1 if there's no match.
	autocmd BufWritePost *.rb silent AsyncRun! -strip
				\ $HOME/.rbenv/shims/bundle exec rubocop
				\ --format emacs --auto-correct-all
				\ $(VIM_FILEPATH)
				\ | { grep -v 'C: \[Correct' || true; }
augroup END
