setlocal ts=4 sw=4 sts=0 expandtab linebreak wrap

" strike
nnoremap gs I~~<ESC>A~~<ESC>
" check / cross
nnoremap gc :s/\[ \]/\[x\]/<CR>
nnoremap gx :s/\[ \]/\[x\]/<CR>

augroup markdown_autocmd
	autocmd!
	autocmd BufWritePost <buffer> silent AsyncRun -strip
				\ vale
				\ --output=line
				\ $(VIM_FILEPATH)
augroup END
