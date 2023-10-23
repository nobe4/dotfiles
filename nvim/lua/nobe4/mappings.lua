local M = {}

local options = { noremap = true, silent = false }
local map = vim.keymap.set

-- Space is the Leader key
map("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "zf", "zM100zozz", options) -- Fold to current level

-- Move vertically
map("n", "j", "gj", options)
map("n", "k", "gk", options)
map("v", "j", "gj", options)
map("v", "k", "gk", options)

-- Keep search centered
map("n", "n", "nzz", options)
map("n", "N", "Nzz", options)

-- Move block of text
-- map("v", "<Up>", ":m '<-2<CR>gv=gv")
-- map("v", "<Down>", ":m '>+1<CR>gv=gv")

map("n", "gp", "'[v']", options) -- Select last pasted zone
map("v", "@", ":norm@", options) -- Replay mapping over visual

map("n", "<Leader>y", '"+y', options)
map("n", "<Leader>Y", '"+Y', options)
map("v", "<Leader>y", '"+y', options)

map("n", "<Leader>w", ":noautocmd w<CR>", options) -- Save file without autocmd
map("n", "<Leader>q", ":quit!", options)
map("n", "<Leader>x", ":xit", options)
map("n", "<Leader>m", ":make", options)
map("n", "<Leader>R", ":nnoremap <lt>Leader>r :", options)                                              -- Prepare a quick command: http://vi.stackexchange.com/a/3136/1821
map("n", "<Leader>r", ":<UP>", options)                                                                 -- repeat last command

map("n", "go", ":call system('open ' . expand('<cWORD>'))<CR>", options)                                -- open WORD under cursor
map("n", "gf", ":e <cfile><CR>", options)                                                               -- open file under cursor

map("n", "<Leader>b", ":b#<CR>", options)                                                               -- show buffer list
map("n", "<Leader>l", ":ls<CR>:buffer<Space>", options)                                                 -- show buffers and wait for a selection
map("n", "<Leader><Leader>", ":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", options) -- clear highlight
map("n", '"p', [[:reg <bar> exec 'normal!"'.input('>').'p'<CR>]], options)                              -- show registers value before pasting

map("c", "<C-A>", "<Home>", options)                                                                    -- Go to the start of the command line

-- Add edition breakpoint on different keypress
map("i", "<CR>", "<C-G>u<CR>", options)
map("i", "<C-U>", "<C-G>u<C-U>", options)
map("i", "<C-W>", "<C-G>u<C-W>", options)

map("c", "<C-F>", "<C-R>=expand('%:p:h')<CR>/", options)                    -- Insert path to current file
map("n", "<Leader>e", ":edit <C-R>=expand('%:p:h')<CR>/", options)          -- Prepare to edit a file in the same folder as the current one
map("n", "<Leader>z", ":execute 'tabnew +' . line('.') .' %'<CR>", options) -- Zoom in current buffer
map("t", "<Esc>", [[<C-\><C-n>]], options)                                  -- Escape in terminal

-- Fugitive
map("n", "<Leader>gs", ":tabnew +Git status<CR>", options)
map("n", "<Leader>gp", ":!gp", options)
map("n", "<Leader>gl", ":Git pull", options)
map("n", "<Leader>gb", ":GBrowse<CR>", options)
map("v", "<Leader>gb", ":GBrowse<CR>", options)

-- VimCorrect
map("n", "Z=", ":Correct<CR>", options)

-- EasyAlign
map("x", "ga", "<Plug>(EasyAlign)", options)
map("n", "ga", "<Plug>(EasyAlign)", options)

map("n", "<Leader>ut", function()
	print("Use :UndotreeToggle")
end, options)

-- unimpaired-like
-- Inspired by https://git.io/vHtuc
local function map_braquet(map_key, cmd)
	map("n", "]" .. map_key, ":" .. cmd .. "next<CR>", options)
	map("n", "[" .. map_key, ":" .. cmd .. "previous<CR>", options)
	map("n", "]" .. map_key:upper(), ":" .. cmd .. "last<CR>", options)
	map("n", "[" .. map_key:upper(), ":" .. cmd .. "first<CR>", options)
end

map_braquet("q", "c") -- jump between items in the (q)uickfix list
map_braquet("t", "t") -- jump between matching (t)ags
map_braquet("l", "l") -- jump between lines in the (l)ocation list

-- Goto next/prev "Error"
map("n", "]e", vim.diagnostic.goto_next, options)
map("n", "[e", vim.diagnostic.goto_prev, options)
map("n", "[o", vim.diagnostic.open_float, options)

-- vim-tmux-navigator
vim.g.tmux_navigator_no_mappings = 1
map("", "<C-Left>", ":<C-U>TmuxNavigateLeft<CR>", options)
map("", "<C-Right>", ":<C-U>TmuxNavigateRight<CR>", options)
map("", "<C-Down>", ":<C-U>TmuxNavigateDown<CR>", options)
map("", "<C-Up>", ":<C-U>TmuxNavigateUp<CR>", options)

-- LSP
M.lsp_mappings = function(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map("n", "K", vim.lsp.buf.hover, bufopts)
	map("n", "gr", vim.lsp.buf.rename, bufopts)
	map("n", "gd", vim.lsp.buf.definition, bufopts)
	map("n", "gR", vim.lsp.buf.references, bufopts)
	map("n", "gc", vim.lsp.buf.code_action, bufopts)
end

-- Telescope
M.telescope = function(ts_builtin)
	map("n", "<Leader>f", ts_builtin.find_files, options)
	map("n", "<Leader>t", ts_builtin.tags, options)
	map("n", "<Leader>:", ts_builtin.commands, options)
	map("n", "<Leader>?", ts_builtin.help_tags, options)
	map("n", [[<leader>\]], ts_builtin.live_grep, options)
	map("n", [[\]], ts_builtin.grep_string, options)

	-- Notational
	-- TODO: find a way to search for the filename as well
	-- map("n", "<Leader>n", function()
	-- 	ts_builtin.live_grep({
	-- 		cwd = "~/Documents/docs",
	-- 		glob_pattern = { "*.md", "*.txt" },
	-- 	})
	-- end, options)
end

return M
