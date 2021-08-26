" Works by doing a big `rg 'pattern' 'paths'` + fzf + preview and open the
" note in vim once it's found. Custom handler is used for creating a new note
" if none was found.

" Variables
let g:notational_default_save_path = '~/Documents/docs'
let g:notational_search_paths = g:notational_default_save_path . ' .'
let s:create_note_key = 'ctrl-n'

" Sources
let s:source_command='command rg --follow --smart-case --color=always --colors="match:none" --line-number --no-messages --no-heading --with-filename --glob "*.md" "\S" ' . g:notational_search_paths
let s:preview_command=shellescape('rg --color=always --colors="match:fg:blue" -C4 {3} --fixed-strings {1}')

" Handle fzf results
function s:handler(results) abort
    try
        " Edit either the query, or the matched file
        if len(a:results) == 2  || a:results[1] == s:create_note_key
            execute 'edit ' . fnameescape(g:notational_default_save_path  . '/' . substitute(a:results[0], ' ', '_', 'g') . '.md')
        else
            let lineinfo = split(a:results[2], ":")
            execute 'edit +' . lineinfo[1] . ' ' . fnameescape(lineinfo[0])
        endif
    catch
        echomsg "Notational Error: " . v:exception
    endtry
endfunction

" Command, relies on fzf
command! Notational
    \ call fzf#run(
    \ fzf#wrap({
        \ 'sink*': function('<sid>handler'),
        \ 'source': s:source_command,
        \ 'options': join([
            \ '--print-query',
            \ '--ansi',
            \ '--exact',
            \ '--inline-info',
            \ '--delimiter=":"',
            \ '--color=16,hl+:4,hl:4,fg+:-1',
            \ '--with-nth=' . '1..',
            \ '--tiebreak=length,begin',
            \ '--expect=' . s:create_note_key,
            \ '--preview=' . s:preview_command,
            \ '--preview-window=40%:wrap'
            \ ]),
    \ },<bang>0))

