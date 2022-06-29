" This folder/file is used to determine correctly the filetype of special
" files

autocmd BufNewFile,BufRead *.zsh       set filetype=sh
autocmd BufNewFile,BufRead *.bash      set filetype=sh

autocmd BufNewFile,BufRead *.graphql   set filetype=graphql
autocmd BufNewFile,BufRead *.jspf      set filetype=jsp

autocmd BufNewFile,BufRead *.md        set filetype=markdown
autocmd BufNewFile,BufRead *.sls       set filetype=yaml

autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

autocmd BufNewFile,BufRead *.coffee    set filetype=javascript
autocmd BufNewFile,BufRead *.gs        set filetype=javascript

autocmd BufNewFile,BufRead *.tfstate   set filetype=json
autocmd BufNewFile,BufRead *.tfvars    set filetype=terraform

autocmd BufNewFile,BufRead *.svelte    set filetype=svelte
autocmd BufNewFile,BufRead *.vue       set filetype=vuejs

autocmd BufNewFile,BufRead *.scss      set filetype=scss
autocmd BufNewFile,BufRead *.styl      set filetype=stylus
