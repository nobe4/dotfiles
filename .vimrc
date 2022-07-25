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
Plug expand('~/Documents/dev/mnml.vim')
" Plug 'nobe4/mnml.vim'
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
autocmd FileType html,css,less,eruby,jsp,jspf,htmldjango,vue,svelte EmmetInstall
" }
" danro/rename.vim {
Plug 'danro/rename.vim', { 'on': 'Rename' }
" }
" romainl/vim-qf {
Plug 'romainl/vim-qf'
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
let g:fzf_buffers_jump = 1

nnoremap <leader>f :FZF<CR>
nnoremap <leader>t :Tags <C-R><C-W><CR>
" }
" junegunn/vim-easy-align {
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups = []
" }
" skywind3000/asyncrun.vim {
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 0
let g:asyncrun_trim = 1
" Auto open/close the quickfix window depending on the content.
let g:asyncrun_exit = 'silent checktime | exec (len(getqflist())==0?"cclose":"copen 5")'

" Custom prettier format
set errorformat+=[error]\ %f:\ %m\ (%l:%c)
" }
" tpope/* {
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :tabnew +Git status<CR>
nnoremap <Leader>gp :Git push -uq
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
set ttimeout
set timeoutlen=300
set ttimeoutlen=300
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

" Have all emojis take double-width, so it's possible to work with them.
set noemoji

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

" Cursor is a vertical line in insert, and a block otherwise.
" ref: https://stackoverflow.com/a/6489348
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Highlight the cursorline during insertmode.
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
" Open cwindow automatically if there are items in it
" autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost * botright copen 5
autocmd BufWritePre * :exec 'norm m`' | %s/\s\+$//e | norm g``'
" }
" Multiple windows {
set hidden " Allow hidden non-written buffers
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
" Fold "focus" fold all but current one, and center the view
nnoremap zf zM100zozz
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
autocmd! BufWritePost espanso_config.yml !espanso restart&

autocmd! FocusGained * :redraw!
" }
" Encoding {
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

" [ / ] mappings
" I only use those mapping in tpope/vim-unimpaired.
call map_next#Run('q','c')
call map_next#Run('t','t')

" Remove the ex mode
nnoremap Q <NOP>

" Select last pasted text
noremap gp '[v']

" Replay mapping over visual selection
vnoremap @ :norm@

" Deal with errors/warnings, in the location list.
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>

" edit, source/reload .vimrc
command! SourceVimrc :silent source $MYVIMRC
command! VimrcSource :silent source $MYVIMRC
command! EditVimrc :edit $MYVIMRC
command! VimrcEdit :edit $MYVIMRC

" Change content of check box
nnoremap <Leader>d 0/\[.\]<CR>:nohlsearch<CR><right>s

" Save file without autocmd
" I'm saving compulsively my work, but I don't want to be interrupted.
" Only have the post-save works run on manual :w<CR>
nnoremap <Leader>w :noautocmd w<CR>
nnoremap <Leader>q :quit!
nnoremap <Leader>x :xit
nnoremap <Leader>m :make


" Prepare a quick command
" http://vi.stackexchange.com/a/3136/1821
nnoremap <Leader>R :nnoremap <lt>Leader>r :
" Repeat the last command
nnoremap <Leader>r :<UP>

" Force save
command! SudoWrite :w !sudo tee % >/dev/null
command! WriteSudo :w !sudo tee % >/dev/null

" Don't save a filename with name ' or ;
cnoremap w' w
cnoremap w; w

" Use bash-like shortcuts to go to start/end of command line.
" C-E already goes to the end.
cnoremap <C-A> <Home>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Rg :silent! grep! <args>|cwindow|redraw!
nnoremap \ :Rg<Space>

" Before <CR> or deleting from insert mode, create a new change point
inoremap <CR> <C-G>u<CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

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

" <C-o> to open
nnoremap g<Leader>o :AsyncRun open .<CR><CR>
nnoremap <Leader>o yiW:AsyncRun open <C-R>"<CR><CR>
"}
" Abbreviations {
iabbrev :shrug: ¯\_(ツ)_/¯
"}
" Tmux {
autocmd BufReadPost,FileReadPost,BufNewFile *
    \ call system("tmux rename-window 'vim:" . expand("%:t") . "'")
autocmd VimLeave *
    \ call system("tmux setw automatic-rename")
" }
" Mouse {
set mouse=
if !has('nvim')
    set ttymouse=xterm2
endif
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

command! JSONPretty :%!jq '.'
command! QFixEdit :call qfix_edit#run()

command! Writing :setlocal wrap linebreak spell spellcapcheck= filetype=markdown
command! CenterColumn :call center_column#run()
command! ScreenCapture :call screen_capture#Run()
nnoremap <silent> <Leader>n :call notational#run()<CR>
" }
