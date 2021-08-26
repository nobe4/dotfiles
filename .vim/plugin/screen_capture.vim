" Capture what vim "sees" and puts it in a new tab.

function! ScreenCapture()
    let array=[]
    for i in range(1,&lines)
        let row=''
        for j in range(1,&columns)
            let row.=nr2char(screenchar(i,j))
        endfor
        call add(array, row)
    endfor
    tabnew
    call setline(1,array)
endfunction
