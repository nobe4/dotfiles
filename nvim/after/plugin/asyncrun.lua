vim.g.asyncrun_open = 0
vim.g.asyncrun_trim = 1
-- Auto open/close the quickfix window depending on the content.
vim.g.asyncrun_exit = 'silent checktime | exec (len(getqflist())==0?"cclose":"copen 5")'
