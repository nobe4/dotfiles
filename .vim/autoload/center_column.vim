" Create a centered column to write stuff more easily
function! center_column#run()
    vnew
    vnew
    wincmd L
    wincmd =
    wincmd h
    set nonumber
    set wrap
    set linebreak
endfunction
