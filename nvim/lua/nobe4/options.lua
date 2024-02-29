-- Text
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { tab = "· ", trail = "·", extends = "›", precedes = "‹", nbsp = "·" }
vim.opt.fillchars = { vert = " ", fold = "-" }
vim.opt.emoji = false -- Have all emojis take double-width, so it's possible to work with them.
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.textwidth = 80
vim.opt.cursorline = true

vim.opt.background = "dark"
vim.opt.guifont = "CommitMono:h14"
vim.opt.termguicolors = true
vim.cmd("colorscheme mnml")

-- Editing
vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.spellcapcheck = ""
vim.opt.autoread = true
vim.opt.updatecount = 200
vim.opt.fileencoding = "utf-8"
-- vim.opt.iskeyword:append "-"
-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.timeoutlen = 300
-- vim.opt.ttimeoutlen = 300

-- Movement
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
-- Fold
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldopen = { "insert", "percent", "quickfix", "tag", "search" }
vim.opt.wildmode = { "longest", "list", "full" }

-- Menu
vim.opt.completeopt = { "menu", "preview" }
vim.opt.wildmenu = true
vim.opt.undofile = true
vim.opt.wildignore:append([[*.pyc]])

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.mouse = ""
vim.opt.signcolumn = "number"

-- Misc
vim.opt.tags:append(".git/tags")
-- vim.opt.errorformat:append "[error] %f: %m (%l:%c)"

-- ripgrep
if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --no-heading"
	vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.g.godot_executable = "/Applications/Godot.app/Contents/MacOS/Godot"

if vim.g.neovide then
	vim.opt.mouse = "a"
	vim.opt.linespace = 1
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_theme = "auto"
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.95
	local alpha = string.format("%x", math.floor(255 * vim.g.transparency))
	vim.g.neovide_background_color = "#1d1f21" .. alpha
	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_bottom = 5
	vim.g.neovide_padding_right = 10
	vim.g.neovide_padding_left = 10
end
