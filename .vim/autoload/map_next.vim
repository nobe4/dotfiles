" I only use those mapping in tpope/vim-unimpaired...
" Inspired by https://git.io/vHtuc
function map_next#Run(map, cmd)
  let map = '<Plug>unimpaired'.toupper(a:map)
  let end = '"<CR>'.(a:cmd == 'c' ? 'zv' : '')
  execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.a:cmd.'previous'.end
  execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.a:cmd.'next'.end
  execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.a:cmd.'first'.end
  execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.a:cmd.'last'.end
  execute 'nmap <silent> ['.        a:map .' '.map.'Previous'
  execute 'nmap <silent> ]'.        a:map .' '.map.'Next'
  execute 'nmap <silent> ['.toupper(a:map).' '.map.'First'
  execute 'nmap <silent> ]'.toupper(a:map).' '.map.'Last'
endfunction
