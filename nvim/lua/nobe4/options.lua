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

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd("colorscheme mnml")
vim.opt.guifont = "Source Code Pro:h11"

-- Vimr doesn't like mnml somehow
if vim.fn.has("gui_vimr") == 1 then
	vim.cmd("colorscheme desert")
end

-- Editing
vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
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
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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
