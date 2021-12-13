autocmd BufNewFile,BufFilePre,BufRead *.coffee    set filetype=javascript
autocmd BufNewFile,BufFilePre,BufRead *.gs        set filetype=javascript
autocmd BufNewFile,BufFilePre,BufRead *.coffee    set filetype=javascript
autocmd BufNewFile,BufFilePre,BufRead *.jspf      set filetype=jsp
autocmd BufNewFile,BufFilePre,BufRead *.graphql   set filetype=graphql
autocmd BufNewFile,BufFilePre,BufRead *.sls       set filetype=yaml
autocmd BufNewFile,BufFilePre,BufRead *.md        set filetype=markdown
autocmd BufNewFile,BufFilePre,BufRead *.tfstate   set filetype=json
autocmd BufNewFile,BufFilePre,BufRead *.tfvars    set filetype=terraform
autocmd BufNewFile,BufFilePre,BufRead Vagrantfile set filetype=ruby

autocmd BufNewFile,BufFilePre,BufRead *.vue       setlocal foldmethod=indent
