local M = {}

local snipe = require("nobe4/function/snipe")

local default_opts = { noremap = true, silent = false }
local map = function(mod, left, right, opts)
	if not opts then opts = default_opts end
	vim.keymap.set(mod, left, right, opts)
end

-- Space is the Leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "zf", "zM100zozz") -- Fold to current level

-- Move vertically
for _, command in pairs({ "j", "k", "<DOWN>", "<UP>" }) do
	map("n", command, "g" .. command)
	map("v", command, "g" .. command)
end

-- Remap search jumps to be snipped
for _, command in pairs({ "n", "N", "*", "#" }) do
	map("n", command, function()
		local ok, _ = pcall(vim.cmd, "normal! " .. command .. "zz")
		if ok then snipe() end
	end)
end
-- <CR> for search should also be snipped
map("c", "<CR>", function()
	local type = vim.fn.getcmdtype()

	-- send another <CR> to validate the search
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes("<CR>", true, true, true),
		"n",
		false
	)

	if type == "/" or type == "?" then
		snipe()
	end
end, { expr = true, silent = true })

map("n", "gp", "'[v']") -- Select last pasted zone
map("v", "@", ":norm@") -- Replay mapping over visual

map("n", "<Leader>y", '"+y')
map("n", "<Leader>Y", '"+Y')
map("v", "<Leader>y", '"+y')

-- Undo those mappings now that gc is built-in
map("n", "<Leader>cc", function() error("\n\nUse gcc\n") end)
map("v", "<Leader>c", function() error("\n\nUse gc\n") end)

map("n", "<Leader>w", ":noautocmd w<CR>") -- Save file without autocmd
map("n", "<Leader>q", ":quit!")
map("n", "<Leader>x", ":xit")
map("n", "<Leader>m", ":make")
map("n", "<Leader>R", ":nnoremap <lt>Leader>r :") -- Prepare a quick command: http://vi.stackexchange.com/a/3136/1821
map("n", "<Leader>r", ":<UP>")                    -- repeat last command

map("n", "<Leader>b", ":b#<CR>")                  -- show buffer list
map("n", "<Leader>l", ":ls<CR>:buffer<Space>")    -- show buffers and wait for a selection

map("n", "<Leader><Leader>",
	":<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>"
)                                                                 -- clear highlight
map("n", '"p', [[:reg <bar> exec 'normal!"'.input('>').'p'<CR>]]) -- show registers value before pasting

map("n", "<C-W><S-Left>", "<C-W>H")                               -- Move to the left window
map("n", "<C-W><S-Right>", "<C-W>L")                              -- Move to the right window
map("n", "<C-W><S-Up>", "<C-W>K")                                 -- Move to the upper window
map("n", "<C-W><S-Down>", "<C-W>J")                               -- Move to the lower window

map("c", "<C-A>", "<Home>")                                       -- Go to the start of the command line

-- Add edition breakpoint on different keypress
map("i", "<CR>", "<C-G>u<CR>")
map("i", "<C-U>", "<C-G>u<C-U>")
map("i", "<C-W>", "<C-G>u<C-W>")

map("c", "<C-F>", "<C-R>=expand('%:p:h')<CR>/")                    -- Insert path to current file
map("n", "<Leader>e", ":edit <C-R>=expand('%:p:h')<CR>/")          -- Prepare to edit a file in the same folder as the current one
map("n", "<Leader>z", ":execute 'tabnew +' . line('.') .' %'<CR>") -- Zoom in current buffer
map("t", "<Esc>", [[<C-\><C-n>]])                                  -- Escape in terminal

-- Fugitive
map("n", "<Leader>gs", ":tabnew +Git status<CR>")
map("n", "<Leader>gp", ":!gp")
map("n", "<Leader>gl", ":Git pull")
map("n", "<Leader>gb", ":GBrowse<CR>")
map("v", "<Leader>gb", ":GBrowse<CR>")

-- VimCorrect
map("n", "Z=", ":Correct<CR>")

-- EasyAlign
map("x", "ga", "<Plug>(EasyAlign)")
map("n", "ga", "<Plug>(EasyAlign)")

map("n", "<Leader>ut", function() print("Use :UndotreeToggle") end)

-- unimpaired-like
-- Inspired by tpope/unimpaired
local function map_bracket(map_key, cmd)
	map("n", "]" .. map_key, function()
		local ok, _ = pcall(vim.cmd, cmd .. "next")
		if not ok then
			vim.cmd(cmd .. "first")
		end
		snipe()
	end)

	map("n", "[" .. map_key, function()
		local ok, _ = pcall(vim.cmd, cmd .. "previous")
		if not ok then
			vim.cmd(cmd .. "last")
		end
		snipe()
	end)

	map("n", "]" .. map_key:upper(), function()
		vim.cmd(cmd .. "last")
		snipe()
	end)
	map("n", "[" .. map_key:upper(), function()
		vim.cmd(cmd .. "first")
		snipe()
	end)
end

map_bracket("t", "t") -- jump between matching (t)ags
map_bracket("l", "l") -- jump between lines in the (l)ocation list

map("n", "]d", function() error("\n\nUse ]q\n") end)
map("n", "[d", function() error("\n\nUse [q\n") end)

-- Use ]q/[q to move between quickfix and diagnostics
map("n", "]q", function()
	local ok, _ = pcall(vim.cmd, "cnext")
	if ok then return end

	if vim.diagnostic.count() ~= 0 then
		vim.diagnostic.goto_next()
	else
		vim.cmd("cfirst")
	end

	snipe()
end)

map("n", "[q", function()
	local ok, _ = pcall(vim.cmd, "cprev")
	if ok then return end

	if vim.diagnostic.count() ~= 0 then
		vim.diagnostic.goto_prev()
	else
		vim.cmd("clast")
	end
	snipe()
end)

map("n", "[o", vim.diagnostic.open_float)

map("n", "T", function() require("trouble").toggle("diagnostics") end)

-- map("n", "gm", ":RLMark ")
-- map("n", "gt", ":RLTravel ")

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

	print("Don't know how to open:", word)
end)

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
	map("n", "<Leader>f", ts_builtin.find_files)
	map("n", "<Leader>t", ts_builtin.tags)
	map("n", "<Leader>:", ts_builtin.commands)
	map("n", "<Leader>?", ts_builtin.help_tags)
	map("n", [[\]], ts_builtin.grep_string)
	map("n", "|", ts_builtin.live_grep)

	-- Notational
	-- TODO: find a way to search for the filename as well
	-- map("n", "<Leader>n", function()
	-- 	ts_builtin.live_grep({
	-- 		cwd = "~/Documents/docs",
	-- 		glob_pattern = { "*.md", "*.txt" },
	-- 	})
	-- end, options)
end

-- Obsidian
M.obsidian = {
	["<leader>f"] = {
		action = function() vim.cmd(":ObsidianSearch") end,
	},
	["<leader>t"] = {
		action = function() vim.cmd(":ObsidianTags") end,
	},
	["<leader>b"] = {
		action = function() vim.cmd(":ObsidianBacklinks") end,
	},
	["<cr>"] = {
		action = function()
			return require("obsidian").util.smart_action()
		end,
		opts = { buffer = true, expr = true },
	}
}

return M
