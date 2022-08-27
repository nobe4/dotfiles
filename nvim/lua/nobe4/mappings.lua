local options = { noremap = true, silent = false }
local map = vim.api.nvim_set_keymap

-- Space is the leader key
map("", "<Space>" , "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "Q", "<NOP>", options)

map("n", "zf", "zM100zozz", options)

-- Move vertically
map("n", "j", "gj", options)
map("n", "k", "gk", options)
map("v", "j", "gj", options)
map("v", "k", "gk", options)
map("n", "gp", "'[v']", options) -- Select last pasted zone
map("v", "@", ":norm@", options) -- Replay mapping over visual

map("n", "<Leader>lo", ":lopen<CR>", options)
map("n", "<Leader>ln", ":lnext<CR>", options)
map("n", "<Leader>lp", ":lprev<CR>", options)

map("n", "<Leader>d", [[0/\[.\]<CR>:nohlsearch<CR><right>s]], options)
map("n", "<Leader>w", ":noautocmd w<CR>", options) -- Save file without autocmd
map("n", "<Leader>q", ":quit!", options)
map("n", "<Leader>x", ":xit", options)
map("n", "<Leader>m", ":make", options)

-- Prepare a quick command: http://vi.stackexchange.com/a/3136/1821
map("n", "<Leader>R", ":nnoremap <lt>Leader>r :", options)
map("n", "<Leader>r", ":<UP>", options)
map("n", "\\", ":Rg<Space>", options)

map("n", "<Leader>o", ":call system('open ' . expand('<cWORD>'))<CR>", options)
map("n", "gf", ":e <cfile><CR>", options)

map("n", "<Leader>yc", '"+yy', options)
map("v", "<Leader>yc", '"+y', options)

map("n", "<Leader>b", ":b#<CR>", options)
map("n", "<Leader>l", ":ls<CR>:buffer<Space>", options)
map("n", "<Leader><Leader>", ":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", options)

-- Visualisation of the register before pasting
map("n", '"p', [[:reg <bar> exec 'normal!"'.input('>').'p'<CR>]], options)

map("c", "w'", "w", options)
map("c", "w;", "w", options)
map("c", "<C-A>", "<Home>", options)

map("i", "<CR>", "<C-G>u<CR>", options)
map("i", "<C-U>", "<C-G>u<C-U>", options)
map("i", "<C-W>", "<C-G>u<C-W>", options)
map("c", "<C-F>", "<C-R>=expand('%:p:h')<CR>/", options)
map("n", "<Leader>e", ":e <C-R>=expand('%:p:h')<CR>/", options)

-- Zoom in current buffer
map("n", "<Leader>z",  [[:execute 'tabnew +' . line(".") .' %'<CR>]], options)
map("n", "<Leader>yp", [[execute 'set paste | normal! "+p | set nopaste']], options)

map("t", "<Esc>", [[<C-\><C-n>]], options)

-- Fugitive
map("n", "<Leader>gs", ":tabnew +Git status<CR>", options)
map("n", "<Leader>gp", ":Git push -uq", options)
map("n", "<Leader>gl", ":Git pull", options)
map("n", "<Leader>gb", ":GBrowse<CR>", options)
map("v", "<Leader>gb", ":GBrowse<CR>", options)

-- Fzf
map("n", "<leader>f",  ":FZF<CR>", options)
map("n", "<leader>t",  ":Tags <C-R><C-W><CR>", options)

-- VimCorrect
map("n", "Z=",  ":Correct<CR>", options)

-- EasyAlign
map("x", "ga", "<Plug>(EasyAlign)", options)
map("n", "ga", "<Plug>(EasyAlign)", options)
map("n", "<leader>ut", ":UndotreeToggle<CR>", options)
map("n", "<leader>uf", ":UndotreeFocus<CR>", options)

-- Notational
map("n", "<Leader>n", ":call notational#run()<CR>", options)

-- unimpaired-like
-- Inspired by https://git.io/vHtuc
local function map_next(map_key, cmd)
  map("n", "[" .. map_key,         "<C-U>execute " .. cmd .. "previous<CR>", options)
  map("n", "]" .. map_key,         "<C-U>execute " .. cmd .. "next<CR>",     options)
  map("n", "[" .. map_key:upper(), "<C-U>execute " .. cmd .. "first<CR>",    options)
  map("n", "]" .. map_key:upper(), "<C-U>execute " .. cmd .. "last<CR>",     options)
end

map_next('q','c') -- jump between errors
map_next('t','t') -- jump between matching tags
