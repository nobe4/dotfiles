augroup yaml_autocmd
	autocmd!
	autocmd! BufWritePost espanso_config.yml silent AsyncRun! -strip espanso restart
augroup END

