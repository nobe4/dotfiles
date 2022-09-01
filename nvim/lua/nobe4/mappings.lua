local options = { noremap = true, silent = false }
local map = vim.keymap.set

-- Space is the Leader key
map("", "<Space>" , "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "zf", "zM100zozz", options) -- Fold to current level

-- Move vertically
map("n", "j", "gj", options)
map("n", "k", "gk", options)
map("v", "j", "gj", options)
map("v", "k", "gk", options)

map("n", "gp", "'[v']", options) -- Select last pasted zone
map("v", "@", ":norm@", options) -- Replay mapping over visual

map("n", "<Leader>d", [[0/\[.\]<CR>:nohlsearch<CR><right>s]], options)
map("n", "<Leader>w", ":noautocmd w<CR>", options) -- Save file without autocmd
map("n", "<Leader>q", ":quit!", options)
map("n", "<Leader>x", ":xit", options)
map("n", "<Leader>m", ":make", options)
map("n", "<Leader>R", ":nnoremap <lt>Leader>r :", options) -- Prepare a quick command: http://vi.stackexchange.com/a/3136/1821
map("n", "<Leader>r", ":<UP>", options) -- repeat last command

map("n", "<Leader>o", ":call system('open ' . expand('<cWORD>'))<CR>", options) -- open WORD under cursor
map("n", "gf", ":e <cfile><CR>", options) -- open file under cursor

map("n", "<Leader>b", ":b#<CR>", options) -- show buffer list
map("n", "<Leader>l", ":ls<CR>:buffer<Space>", options) -- show buffers and wait for a selection
map("n", "<Leader><Leader>", ":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", options) -- clear highlight
map("n", '"p', [[:reg <bar> exec 'normal!"'.input('>').'p'<CR>]], options) -- show registers value before pasting

map("c", "<C-A>", "<Home>", options) -- Go to the start of the command line

-- Add edition breakpoint on different keypress
map("i", "<CR>", "<C-G>u<CR>", options)
map("i", "<C-U>", "<C-G>u<C-U>", options)
map("i", "<C-W>", "<C-G>u<C-W>", options)

map("c", "<C-F>", "<C-R>=expand('%:p:h')<CR>/", options) -- Insert path to current file
map("n", "<Leader>e", ":edit <C-R>=expand('%:p:h')<CR>/", options) -- Prepare to edit a file in the same folder as the current one
map("n", "<Leader>z", ":execute 'tabnew +' . line('.') .' %'<CR>", options) -- Zoom in current buffer
map("t", "<Esc>", [[<C-\><C-n>]], options) -- Escape in terminal

-- /!\ Not working
-- map("n", "<Leader>yp", function()
--   vim.o.paste = true
--   vim.api.nvim_paste(vim.fn.getreg('"'))
--   vim.o.paste = false
-- end, options)

-- Fugitive
map("n", "<Leader>gs", ":tabnew +Git status<CR>", options)
map("n", "<Leader>gp", ":Git push -uq", options)
map("n", "<Leader>gl", ":Git pull", options)
map("n", "<Leader>gb", ":GBrowse<CR>", options)
map("v", "<Leader>gb", ":GBrowse<CR>", options)

-- Fzf
map("n", "<Leader>f",  function() require('telescope.builtin').find_files() end, options)
map("n", "<Leader>t",  function() require('telescope.builtin').tags() end, options)
map("n", [[\]], function() require('telescope.builtin').live_grep() end, options)

-- VimCorrect
map("n", "Z=",  ":Correct<CR>", options)

-- EasyAlign
map("x", "ga", "<Plug>(EasyAlign)", options)
map("n", "ga", "<Plug>(EasyAlign)", options)
map("n", "<Leader>ut", ":UndotreeToggle<CR>", options)
map("n", "<Leader>uf", ":UndotreeFocus<CR>", options)

-- Notational
-- TODO: find a way to search for the filename as well
map("n", "<Leader>n", function()
  require('telescope.builtin').live_grep({
    cwd = "~/Documents/docs",
    glob_pattern = { '*.md', '*.txt' },
  })
end, options)

-- unimpaired-like
-- Inspired by https://git.io/vHtuc
local function map_next(map_key, cmd)
  map("n", "]" .. map_key,         ":" .. cmd .. "next<CR>",     options)
  map("n", "[" .. map_key,         ":" .. cmd .. "previous<CR>", options)
  map("n", "]" .. map_key:upper(), ":" .. cmd .. "last<CR>",     options)
  map("n", "[" .. map_key:upper(), ":" .. cmd .. "first<CR>",    options)
end

map_next('q','c') -- jump between items in the (q)uickfix list
map_next('t','t') -- jump between matching (t)ags
map_next('l','l') -- jump between lines in the (l)ocation list

-- LuaSnip
local ls = require("luasnip")

map({ "i", "s" }, "<C-K>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    print("NOP")
  end
end, { silent = true })

map({ "i", "s" }, "<C-J>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

map({ "i", "s" }, "<C-L>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
