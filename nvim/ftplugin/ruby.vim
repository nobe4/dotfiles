" Ruby foldmethod is slow with the regexengine 0
setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10
iabbrev ;debug; require "pry"; binding.pry
iabbrev ;pry; require "pry"; binding.pry
iabbrev debug; require "pry"; binding.pry
iabbrev pry; require "pry"; binding.pry

nnoremap <leader>m :execute 'split term://bundle exec rspec --fail-fast %\:' . (line(".") + 1)<CR>

command! RubyCallToExpect :lua ruby_call_to_expect()
command! RubyLibToSepc :lua ruby_lib_to_spec()
