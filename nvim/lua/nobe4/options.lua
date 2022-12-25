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

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.guifont = "Source Code Pro:h11"
vim.cmd("colorscheme mnml")

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
vim.opt.completeopt = { "menu", "preview" }
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.foldopen = { "insert", "percent", "quickfix", "tag", "search" }
vim.opt.foldlevelstart = 99
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true
vim.opt.undofile = true
vim.opt.wildignore:append([[*.pyc]])
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "number"

-- Misc
vim.opt.tags:append(".git/tags")
-- vim.opt.errorformat:append "[error] %f: %m (%l:%c)"

-- ripgrep
if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --no-heading"
	vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
