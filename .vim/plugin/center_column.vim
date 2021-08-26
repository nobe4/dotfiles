" Create a centered column to write stuff more easily
function! CenterColumn()
    vnew
    vnew
    wincmd L
    wincmd =
    wincmd h
    set nonumber
    set wrap
    set linebreak
endfunction
