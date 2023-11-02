" Ruby foldmethod is slow with the regexengine 0
setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10

" Test current method
nnoremap <leader>m :execute 'split term://bundle exec rspec --fail-fast %\:' . (line(".") + 1)<CR>
