" Introduction and notes {
" vim: sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldmethod=marker spell:
"
"                 _             ___
"                | |           /   |
"     _ __   ___ | |__   ___  / /| |
"    | '_ \ / _ \| '_ \ / _ \/ /_| |
"    | | | | (_) | |_) |  __/\___  |
"    |_| |_|\___/|_.__/ \___|    |_/
"
"    Personal vimrc of Victor Haffreingue
"    Use it and share it as you like.
"
"    Copyright (C) 2015-2021, Victor Haffreingue
"
"    Permission is hereby granted, free of charge, to any person obtaining a
"    copy of this software and associated documentation files (the "Software"),
"    to deal in the Software without restriction, including without limitation
"    the rights to use, copy, modify, merge, publish, distribute, sublicense,
"    and/or sell copies of the Software, and to permit persons to whom the
"    Software is furnished to do so, subject to the following conditions:
"
"    The above copyright notice and this permission notice shall be included in
"    all copies or substantial portions of the Software.
"
"    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
"    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
"    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
"    DEALINGS IN THE SOFTWARE.
" }
" TODO {
" https://vimways.org/2018/from-vimrc-to-vim/
" }
" Important {
set nocompatible " be iMproved, required
let mapleader="\<Space>" " need to set the mapleader before the plugins
" }
" Plugins {
" Vim-Plug Initialisation {
call plug#begin('~/.vim/plugged')
" }
" nobe4 {
Plug 'nobe4/vimcorrect'
nnoremap Z= :Correct<CR>
Plug 'nobe4/exchange.vim'
Plug 'nobe4/curl.vim'
Plug 'nobe4/mnml.vim'
" }
" editorconfig/editorconfig-vim {
Plug 'editorconfig/editorconfig-vim'
" }
" mattn/gist-vim {
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
let g:gist_post_private = 1
" }
" mbbill/undotree {
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>uf :UndotreeFocus<CR>
" }
" matchit {
Plug 'vim-scripts/matchit.zip'
" }
" mattn/emmet-vim {
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
autocmd FileType html,css,less,eruby,jsp,jspf,htmldjango,vue EmmetInstall
" }
" danro/rename.vim {
Plug 'danro/rename.vim', { 'on': 'Rename' }
" }
" romainl/vim-qf {
Plug 'romainl/vim-qf'
" }
" 'dense-analysis/ale' {
Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_set_signs = 0
let g:ale_ruby_rubocop_executable = $HOME . "/.rbenv/shims/bundle"
let g:ale_linters = {
\   'css': ['prettier'],
\   'go': ['goimports', 'govet', 'gofmt'],
\   'graphql': ['prettier'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'python': ['black'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier'],
\   'terraform': ['terraform'],
\   'vue': ['prettier'],
\   'yaml': ['prettier'],
\   'zsh': ['shellcheck']
\}
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'css': ['prettier'],
\   'go': ['goimports', 'gofmt'],
\   'graphql': ['prettier'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'python': ['black'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier'],
\   'terraform': ['terraform'],
\   'vue': ['prettier'],
\   'yaml': ['prettier']
\}
" }
" scrooloose/nerdcommenter {
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1
let NERDCreateDefaultMappings=0
nmap <leader>c <plug>NERDCommenterToggle
vmap <leader>c <plug>NERDCommenterToggle
" }
" christoomey/vim-tmux-navigator {
Plug 'christoomey/vim-tmux-navigator'
" }
" junegunn/fzf {
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <leader>f :FZF<CR>
nnoremap <leader>t :Tags<CR>
let g:fzf_buffers_jump = 1
" }
" junegunn/vim-easy-align {
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups = []
" }
" tpope/* {
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :tabnew +Git status<CR>
nnoremap <Leader>gp :Git push -u
nnoremap <Leader>gl :Git pull
nnoremap <Leader>gb :GBrowse<CR>
vnoremap <Leader>gb :GBrowse<CR>

Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
" }
" Vim-plug end of Initialisation {
call plug#end()
" }
" ripgrep {
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }
" }
" Moving around, searching and patterns {
set incsearch "highlight as you type you search phrase
set ignorecase " ignore case when using a search pattern
set smartcase  " override 'ignorecase' when pattern has upper case characters
" }
" Tags {
" store tags file under the git directory to exclude from versioning
set tag+=.git/tags
" }
" Displaying text {
set number

" Show invisible characters
set list
set listchars=tab:\·\ ,trail:·,extends:›,precedes:‹,nbsp:·
set fillchars+=vert:\ ,fold:-

set nowrap

" keep 5 lines up/down the cursor
set scrolloff=5

" scroll 1 column at a time
set sidescroll=1
" leave at least 10 column left and right when scrolling horizontally
set sidescrolloff=10
" }
" Syntax, highlighting and spelling {
syntax on " Activate syntax highlighting
set hlsearch
if has('gui_running')
  set guifont=Source\ Code\ Pro:h11
endif

set background=dark

try
    colorscheme mnml
catch /^Vim\%((\a\+)\)\=:E185/
    " Ignore
endtry

set spellcapcheck=
" Clearing uses the current background color
set t_ut=
set t_Co=256 " Number of available colors
" }
" Multiple windows {
set hidden " Allow hidden non-written buffers
set switchbuf=split
" }
" Editing text {
set backspace=indent,eol,start

" Combine comments on joining lines
set formatoptions+=j
set completeopt=menu,preview
" }
" Tabs and indenting {
" Using tpope/vim-sleuth as well.
set noexpandtab " Insert tab
set autoindent " Use the same indent as the previous line
set tabstop=2 " Number of spaces a <Tab> in the text stands for
set shiftwidth=2 " Number of spaces used for each step of (auto)indent
" }
" Folding {
set foldenable " Turn on folding
set foldmethod=syntax " Most of the code will be syntax-indented
" set foldopen=block,hor,mark,percent,quickfix,tag " what movements
set foldlevelstart=99 " disable auto folding on open
augroup ft_rb
    au!
    " Ruby foldmethod is slow with the regexengine 0
    au FileType ruby setlocal regexpengine=1 foldmethod=indent foldlevelstart=1 foldnestmax=10
augroup END
" }
" Reading and writing files {
set autoread
" }
" The swap file {
" Store swap files in fixed location, not current directory.
set directory=~/.vim/swapdir//
set updatecount=200
" }
" Command line editing {
set wildmode=longest,list,full
set wildmenu " Command-line completion shows a list of matches
set undofile " save and restore undo history
set undodir=~/.vim/undodir  " list of directories for undo files
set wildignore+=*.pyc
" }
" executing external commands {
set shell=$SHELL
" }
" Language specific {
" Misc {
autocmd! BufNewFile,BufFilePre,BufRead *.coffee set syntax=javascript
autocmd! BufNewFile,BufFilePre,BufRead *.graphql set filetype=graphql
autocmd! BufNewFile,BufFilePre,BufRead *.gs set syntax=javascript
autocmd! BufNewFile,BufFilePre,BufRead *.jspf set filetype=jsp
autocmd! BufNewFile,BufFilePre,BufRead *.sls set filetype=yaml
autocmd! BufNewFile,BufFilePre,BufRead *.vue setlocal foldmethod=indent
autocmd! BufNewFile,BufFilePre,BufRead Vagrantfile set filetype=ruby
autocmd! BufReadPost *.coffee set syntax=javascript
autocmd! BufReadPost *.gs set syntax=javascript
autocmd! BufWritePost espanso_config.yml !espanso restart&
" }
" Markdown {
autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd! Filetype markdown setlocal ts=4 sw=4 sts=0 expandtab linebreak wrap
" }
" Terraform {
autocmd BufNewFile,BufFilePre,BufRead *.tfstate set filetype=json
autocmd BufNewFile,BufFilePre,BufRead *.tfvars set filetype=terraform
autocmd Filetype tf setlocal foldmethod=indent filetype=terraform
" }
" Commit {
autocmd! Filetype gitcommit set spell
" }
" }
" Multi-byte characters {
scriptencoding=utf-8
set encoding=utf-8 " Character encoding
set fileencoding=utf-8
set termencoding=utf-8
" }
" Mappings {
" move vertically inside wrapping lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" I only use those mapping in tpope/vim-unimpaired...
" Inspired by https://git.io/vHtuc
function! s:MapNextFamily(map,cmd)
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

call s:MapNextFamily('q','c')
call s:MapNextFamily('t','t')

" Select last pasted text
noremap gp '[v']

" Replay mapping over visual selection
vnoremap @ :norm@

" Deal with errors/warnings, in the location list.
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>

" edit, source/reload .vimrc
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vs :so $MYVIMRC<CR>
nnoremap <Leader>vr :so $MYVIMRC<CR>

" Change content of check box
nnoremap <Leader>d 0/\[.\]<CR>:nohlsearch<CR><right>s

" save file
nnoremap <Leader>w :w<CR>
" quit without saving
nnoremap <Leader>q :quit!
" quit after saving
nnoremap <Leader>x :xit

" Quick make
nnoremap <Leader>m :make

" Remove the ex mode
nnoremap Q <NOP>

" Prepare a quick command
" http://vi.stackexchange.com/a/3136/1821
nnoremap <Leader>R :nnoremap <lt>Leader>r :
" Repeat the last command
nnoremap <Leader>r :<UP>

" Force save
cnoremap w!! w !sudo tee % >/dev/null

" Don't save a filename with name ' or ;
cnoremap w' w
cnoremap w; w

" In insert mode <C-\> remove unwanted <CR> insertion
" inoremap <C-\> <C-o>:left 0<Cr><BS>

" In normal mode <C-\> grep for the word under the cursor
" inspiration: https://robots.thoughtbot.com/faster-grepping-in-vim
" nnoremap <C-\> :grep! --word-regexp '<C-R><C-W>'<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Rg :silent! grep! <args>|cwindow|redraw!
nnoremap \ :Rg<Space>

inoremap <CR> <C-G>u<CR>

" Before deleting from insert mode, create a new change
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Create a new tab
nnoremap <Leader>tn :tabnew

" Copy/Paste with system clipboard
function! CmdPaste() abort
    set paste
    normal! "+p
    set nopaste
endfunction

nnoremap <Leader>yp :call CmdPaste()<CR>
nnoremap <Leader>yc "+yy
vnoremap <Leader>yc "+y

" execute cmake from command line
command! -nargs=1 Cmake !cmake "<args>"

" Make gf always work
nnoremap gf :e <cfile><CR>

" Switch to previous buffer
nnoremap <Leader>b :b#<CR>

" Switch to alternate file, thanks to projectionist
nnoremap <Leader>a :A<CR>

" Open buffer list and prepare a switch
nnoremap <Leader>l :ls<CR>:buffer<Space>

" Clear the highlight
nnoremap <silent> <Leader><Leader> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>

" Make <C-F> insert current path in command line mode
cnoremap <C-F> <C-R>=expand('%:p:h')<CR>/
" and <leader>e to edit current file
nnoremap <Leader>e :e <C-R>=expand('%:p:h')<CR>/

" Display a simple help for debugging
cnoremap <C-H> "cont quit next step interrupt finish backtrace up down<CR>

" Enhance the register pasting
nnoremap "p :reg <bar> exec 'normal! "'.input('>').'p'<CR>

" Open current file in a new tab, effectively [z]ooming into it
nnoremap <Leader>z :execute 'tabnew +' . line(".") .' %'<CR>
nnoremap g<C-o> :!open .<CR><CR>
"}
" Abbreviations {
iabbrev pydebug import pdb; pdb.set_trace()
iabbrev rbdebug require 'pry';binding.pry
iabbrev red* * { color: red !important; }
iabbrev :shrug: ¯\_(ツ)_/¯
iabbrev ttt (t *testing.T)
iabbrev forhook for _, e := range hook.Entries { t.Logf("=> %v", e) }
"}
" Tmux {
autocmd BufReadPost,FileReadPost,BufNewFile *
    \ call system("tmux rename-window 'vim:" . expand("%:t") . "'")
autocmd VimLeave *
    \ call system("tmux setw automatic-rename")
" }
" GUI {
" Remove every bit of GUI option
set guioptions=
" Disable audio bell
autocmd! GUIEnter * set vb t_vb=
" }
" Tests {

" Simulate the r operator functionality
function! ROperator()
  call inputsave()
  let l:replace_pattern = input('Replace > ')
  call inputrestore()

  if len(l:replace_pattern) != 3
    throw "Bad pattern size (expected 3)"
  endif

  let l:motion = strpart(replace_pattern, 0, 2)
  let l:char = strpart(replace_pattern, 2, 2)

  execute "normal! v".l:motion."r".l:char
endfunction
nnoremap gr :call ROperator()<CR>

function! FollowCursor(follow)
    if a:follow
        nnoremap j jzz
        nnoremap k kzz
    else
        unmap j
        unmap k
    endif
endfunction
command! FollowCursor :call FollowCursor(1)
command! UnfollowCursor :call FollowCursor(0)


function! s:QFixEdit()
    " Copy the content into a new buffer
    %y
    " TODO: Create a named buffer bound to a file
    let l:tmp_file =system('mktemp')
    execute 'split ' . l:tmp_file
    normal P
    cclose
    " Catch the save and exit events
    autocmd BufWritePre <buffer> :call s:QFixEditSave()
    autocmd BufHidden <buffer> :call s:QFixEditClean()
endfunction

function! s:QFixEditSave()
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

function! s:QFixEditClean()
    echomsg "Cleaning"
endfunction

command! JSONPretty :%!jq '.'
command! QFixEdit :call s:QFixEdit()
command! Writing :setlocal wrap linebreak spell spellcapcheck= filetype=markdown
command! CenterColumn :call CenterColumn()
command! ScreenCapture :call ScreenCapture()

nnoremap <silent> <Leader>n :Notational<CR>
" }
