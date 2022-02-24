" Ruby foldmethod is slow with the regexengine 0
setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10
iabbrev ;debug; require "pry"; binding.pry

augroup ruby_autocmd
	autocmd!
	" Hide rubocop enthusiastic correction messages
	autocmd BufWritePost <buffer> silent AsyncRun -strip
				\ $HOME/.rbenv/shims/bundle exec rubocop
				\ --format emacs --auto-correct-all
				\ $(VIM_FILEPATH)
				\ | grep -v 'C: \[Correct'
augroup END
