function! qfix_edit#run()
    " Copy the content into a new buffer
    %y
    " TODO: Create a named buffer bound to a file
    let l:tmp_file =system('mktemp')
    execute 'split ' . l:tmp_file
    normal P
    cclose
    " Catch the save and exit events
    autocmd BufWritePre <buffer> :call qfix_edit#save()
    autocmd BufHidden <buffer> :call qfix_edit#clean()
endfunction

function! qfix_edit#save()
    let l:i = line("$")
    while i > 1
        let l:i -= 1
        let l:line = split(getline(l:i), '|')

        let l:filename = l:line[0]
        let l:line_number = split(l:line[1], " ")[0]
        let l:content = l:line[2][1:]

        call system('sed -i ".bak" "2'. l:line_number . '/.*/' . l:content . '/" ' . l:filename)
    endwhile
    " Loop through all the lines
    " Parse the file
    " Modify in the files at the lines specified
endfunction

function! qfix_edit#clean()
    echomsg "Cleaning"
endfunction
