local M = {}

local options = { noremap = true, silent = false }
local map = vim.keymap.set

-- Space is the Leader key
map("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "zf", "zM100zozz", options) -- Fold to current level

-- Move vertically
for _, command in pairs({ "j", "k", "<DOWN>", "<UP>" }) do
	map("n", command, "g" .. command, options)
	map("v", command, "g" .. command, options)
end

-- Keep search centered
map("n", "n", "nzz", options)
map("n", "N", "Nzz", options)

map("n", "gp", "'[v']", options) -- Select last pasted zone
map("v", "@", ":norm@", options) -- Replay mapping over visual

map("n", "<Leader>y", '"+y', options)
map("n", "<Leader>Y", '"+Y', options)
map("v", "<Leader>y", '"+y', options)

-- Undo those mappings now that gc is built-in
map("n", "<Leader>cc", function() error("\n\nUse gcc\n") end)
map("v", "<Leader>c", function() error("\n\nUse gc\n") end)

map("n", "<Leader>w", ":noautocmd w<CR>", options) -- Save file without autocmd
map("n", "<Leader>q", ":quit!", options)
map("n", "<Leader>x", ":xit", options)
map("n", "<Leader>m", ":make", options)
map("n", "<Leader>R", ":nnoremap <lt>Leader>r :", options)                                              -- Prepare a quick command: http://vi.stackexchange.com/a/3136/1821
map("n", "<Leader>r", ":<UP>", options)                                                                 -- repeat last command

map("n", "<Leader>b", ":b#<CR>", options)                                                               -- show buffer list
map("n", "<Leader>l", ":ls<CR>:buffer<Space>", options)                                                 -- show buffers and wait for a selection
map("n", "<Leader><Leader>", ":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", options) -- clear highlight
map("n", '"p', [[:reg <bar> exec 'normal!"'.input('>').'p'<CR>]], options)                              -- show registers value before pasting

map("n", "<C-W><S-Left>", "<C-W>H")                                                                     -- Move to the left window
map("n", "<C-W><S-Right>", "<C-W>L")                                                                    -- Move to the right window
map("n", "<C-W><S-Up>", "<C-W>K")                                                                       -- Move to the upper window
map("n", "<C-W><S-Down>", "<C-W>J")                                                                     -- Move to the lower window

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

map("n", "<Leader>ut", function() print("Use :UndotreeToggle") end, options)

-- unimpaired-like
-- Inspired by tpope/unimpaired
local function map_bracket(map_key, cmd)
	map("n", "]" .. map_key, function()
		local ok, _ = pcall(vim.cmd, cmd .. "next")
		if not ok then
			vim.cmd(cmd .. "first")
		end
	end)

	map("n", "[" .. map_key, function()
		local ok, _ = pcall(vim.cmd, cmd .. "previous")
		if not ok then
			vim.cmd(cmd .. "last")
		end
	end, options)

	map("n", "]" .. map_key:upper(), function() vim.cmd(cmd .. "last") end, options)
	map("n", "[" .. map_key:upper(), function() vim.cmd(cmd .. "first") end, options)
end

map_bracket("t", "t") -- jump between matching (t)ags
map_bracket("l", "l") -- jump between lines in the (l)ocation list

-- Use ]q/[q to move between quickfix and diagnostics
map("n", "]q", function()
	local ok, _ = pcall(vim.cmd, "cnext")
	if ok then return end

	if vim.diagnostic.count() ~= 0 then
		vim.diagnostic.goto_next()
	else
		vim.cmd("cfirst")
	end
end)

map("n", "[q", function()
	local ok, _ = pcall(vim.cmd, "cprev")
	if ok then return end

	if vim.diagnostic.count() ~= 0 then
		vim.diagnostic.goto_prev()
	else
		vim.cmd("clast")
	end
end)

map("n", "[o", vim.diagnostic.open_float, options)

map("n", "T", function() require("trouble").toggle("diagnostics") end, options)

-- map("n", "gm", ":RLMark ", options)
-- map("n", "gt", ":RLTravel ", options)

map("n", "go", function()
	-- get WORD under cursor
	local word = vim.fn.expand("<cWORD>")

	-- if it's a full URL
	if word:match("^https?://") then
		vim.cmd("!open " .. word)
		return
	end

	-- if it's a partial GitHub URL
	-- owner/repo#123
	local owner, repo, number = word:match("([^/]+)/([^#]+)#(.+)")
	if owner and repo and number then
		vim.cmd("!open https://github.com/" .. owner .. "/" .. repo .. "/issues/" .. number)
		return
	end

	print("Don't know how to open", word)
end, options)

-- LSP
M.lsp_mappings = function(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
	map("n", [[\]], ts_builtin.grep_string, options)
	map("n", "|", ts_builtin.live_grep, options)

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
