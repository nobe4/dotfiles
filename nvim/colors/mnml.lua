-- reload with <leader>.
vim.g.colors_name = "mnml"
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.cmd.highlight("clear")

local rules = {
	-- Groups
	{ group = "n4_default",                  fg = "lwhite" },

	-- Important: this preserves the terminal background color.
	{ group = "Normal" },

	-- Cursor
	{ group = "Cursor",                      ef = "reverse" },
	{ group = "CursorLine",                  ef = "bold" },
	{ group = "CursorLineNr",                fg = "lwhite",                  ef = "bold" },

	-- Diff
	{ group = "DiffAdd",                     fg = "green" },
	{ group = "DiffAdded",                   lk = "DiffAdd" },
	{ group = "DiffChange",                  fg = "blue" },
	{ group = "DiffDelete",                  fg = "red" },
	{ group = "DiffRemoved",                 lk = "DiffDelete" },
	{ group = "DiffText",                    fg = "yellow" },

	-- Fold
	{ group = "Folded",                      fg = "white" },
	{ group = "FoldColumn",                  lk = "Folded" },

	-- Search
	{ group = "Search",                      fg = "green" },
	{ group = "IncSearch",                   fg = "blue" },
	{ group = "CurSearch",                   fg = "blue" },
	{ group = "Substitute",                  fg = "blue" },

	-- Spelling
	{ group = "SpellBad",                    ef = "underline",               fg = "lred" },
	{ group = "SpellCap",                    lk = "SpellBad" },
	{ group = "SpellLocal",                  lk = "SpellBad" },
	{ group = "SpellRare",                   lk = "SpellBad" },

	-- Status line (Current & Not Current)
	{ group = "StatusLine",                  fg = "black",                   bg = "white" },
	{ group = "StatusLineTerm",              lk = "StatusLineTerm" },
	{ group = "StatusLineNC",                fg = "black",                   bg = "lblack" },
	{ group = "StatusLineTermNC",            lk = "StatusLineTermNC" },
	{ group = "WinSeparator",                bg = "lblack" },

	-- Tab Line
	{ group = "TabLine",                     fg = "lblack" },
	{ group = "TabLineFill",                 fg = "lblack" },
	{ group = "TabLineSel",                  fg = "black",                   bg = "white" },
	{ group = "VertSplit",                   fg = "black",                   bg = "white" },

	-- Errors
	{ group = "WarningMsg",                  fg = "lyellow" },
	{ group = "Error",                       fg = "lred" },
	{ group = "ErrorMsg",                    lk = "Error" },

	-- Misc
	{ group = "Visual",                      ef = "reverse" },
	{ group = "LineNr",                      fg = "lblack" },
	{ group = "MatchParen",                  fg = "blue" },
	{ group = "Directory",                   fg = "blue" },
	{ group = "QuickFixLine",                fg = "white" },
	{ group = "SignColumn",                  fg = "lblack" },
	{ group = "SpecialKey",                  fg = "lblack" },
	{ group = "Title",                       lk = "n4_default" },
	{ group = "FloatBorder",                 fg = "lblack" },
	{ group = "NormalFloat",                 lk = "n4_default" },

	-- Menu bar
	{ group = "Menu",                        fg = "white" },
	{ group = "WildMenu",                    lk = "Menu" },
	{ group = "ModeMsg",                     lk = "Menu" },
	{ group = "MoreMsg",                     lk = "Menu" },
	{ group = "Question",                    fg = "blue" },

	-- End of file / buffer
	{ group = "NonText",                     fg = "lblack" },
	{ group = "EndOfBuffer",                 lk = "NonText" },

	-- Popup Menu
	{ group = "Pmenu",                       lk = "n4_default" },
	{ group = "PmenuSbar",                   lk = "Pmenu" },
	{ group = "PmenuSel",                    ef = "reverse" },
	{ group = "PmenuThumb",                  fg = "black",                   bg = "lwhite" },

	-- Diagnosis
	{ group = "DiagnosticError",             fg = "lred" },
	{ group = "DiagnosticWarn",              fg = "lyellow" },
	{ group = "DiagnosticInfo",              fg = "lblue" },
	{ group = "DiagnosticHint",              fg = "lgreen" },
	{ group = "DiagnosticOk",                fg = "lgreen" },
	{ group = "DiagnosticUnnecessary",       fg = "lred" },
	{ group = "DiagnosticUnderlineError",    ef = "underline",               fg = "lred" },
	{ group = "DiagnosticUnderlineWarn",     ef = "underline",               fg = "lyellow" },
	{ group = "DiagnosticUnderlineInfo",     ef = "underline",               fg = "lblue" },
	{ group = "DiagnosticUnderlineHint",     ef = "underline",               fg = "lgreen" },
	{ group = "DiagnosticUnderlineOk",       ef = "underline",               fg = "lgreen" },

	-- Syntax
	{ group = "Boolean",                     lk = "n4_default" },
	{ group = "Character",                   lk = "n4_default" },
	{ group = "Comment",                     fg = "lblack" },
	{ group = "Conceal",                     lk = "n4_default" },
	{ group = "Conditional",                 lk = "n4_default" },
	{ group = "Constant",                    lk = "Variable" },
	{ group = "Debug",                       lk = "n4_default" },
	{ group = "Define",                      lk = "n4_default" },
	{ group = "Delimiter",                   lk = "n4_default" },
	{ group = "Directive",                   lk = "n4_default" },
	{ group = "Exception",                   lk = "n4_default" },
	{ group = "Float",                       lk = "n4_default" },
	{ group = "Format",                      lk = "n4_default" },
	{ group = "Function",                    lk = "n4_default" },
	{ group = "Identifier",                  lk = "n4_default" },
	{ group = "Ignore",                      fg = "red" },
	{ group = "Include",                     lk = "n4_default" },
	{ group = "Keyword",                     lk = "n4_default" },
	{ group = "Label",                       lk = "n4_default" },
	{ group = "Macro",                       lk = "n4_default" },
	{ group = "NormalNC",                    lk = "n4_default" },
	{ group = "Number",                      fg = "lgreen" },
	{ group = "Operator",                    lk = "n4_default" },
	{ group = "PreCondit",                   lk = "n4_default" },
	{ group = "PreProc",                     lk = "n4_default" },
	{ group = "Repeat",                      lk = "n4_default" },
	{ group = "Special",                     lk = "n4_default" },
	{ group = "SpecialChar",                 lk = "n4_default" },
	{ group = "SpecialComment",              lk = "n4_default" },
	{ group = "Statement",                   lk = "n4_default" },
	{ group = "StorageClass",                lk = "n4_default" },
	{ group = "String",                      fg = "lgreen" },
	{ group = "Structure",                   lk = "n4_default" },
	{ group = "Tag",                         lk = "n4_default" },
	{ group = "Todo",                        fg = "lyellow" },
	{ group = "Type",                        lk = "n4_default" },
	{ group = "Typedef",                     lk = "n4_default" },
	{ group = "Underlined",                  lk = "n4_default" },

	-- HTML
	{ group = "htmlBold",                    lk = "n4_default" },
	{ group = "htmlBoldUnderline",           lk = "n4_default" },
	{ group = "htmlBoldUnderlineItalic",     lk = "n4_default" },
	{ group = "htmlH1",                      lk = "n4_default" },
	{ group = "htmlH2",                      lk = "n4_default" },
	{ group = "htmlH3",                      lk = "n4_default" },
	{ group = "htmlH4",                      lk = "n4_default" },
	{ group = "htmlH5",                      lk = "n4_default" },
	{ group = "htmlH6",                      lk = "n4_default" },
	{ group = "htmlItalic",                  lk = "n4_default" },
	{ group = "htmlTitle",                   lk = "n4_default" },
	{ group = "htmlUnderline",               lk = "n4_default" },
	{ group = "htmlUnderlineItalic",         lk = "n4_default" },

	-- Markdown
	{ group = "markdownCode",                fg = "white" },
	{ group = "markdownCodeBlock",           lk = "markdownCode" },
	{ group = "markdownCodeDelimiter",       lk = "markdownCode" },
	{ group = "markdownHeadingRule",         fg = "blue" },
	{ group = "markdownH1Delimiter",         lk = "markdownHeadingRule" },
	{ group = "markdownH2Delimiter",         lk = "markdownHeadingRule" },
	{ group = "markdownH3Delimiter",         lk = "markdownHeadingRule" },
	{ group = "markdownH4Delimiter",         lk = "markdownHeadingRule" },
	{ group = "markdownH5Delimiter",         lk = "markdownHeadingRule" },
	{ group = "markdownH6Delimiter",         lk = "markdownHeadingRule" },

	-- C
	-- This shows a lot of red somehow :shrug:
	{ group = "cErrInParen",                 lk = "Delimiter" },
	{ group = "cParenError",                 lk = "Delimiter" },

	-- Git/Fugitive
	{ group = "gitHashAbbrev",               fg = "lyellow" },
	{ group = "fugitiveCount",               lk = "n4_default" },
	{ group = "fugitiveStagedHeading",       fg = "lgreen" },
	{ group = "fugitiveStagedModifier",      lk = "fugitiveStagedHeading" },
	{ group = "fugitiveUnstagedHeading",     fg = "lblue" },
	{ group = "fugitiveUnstagedModifier",    lk = "fugitiveUnstagedHeading" },
	{ group = "fugitiveUntrackedHeading",    fg = "lyellow" },
	{ group = "fugitiveUntrackedModifier",   lk = "fugitiveUntrackedHeading" },

	-- Telescope
	{ group = "TelescopeMatching",           lk = "Search" },

	-- nvim-cmp
	-- ref https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
	{ group = "CmpItemAbbrDeprecated",       fg = "lblack",                  ef = "strikethrough" },
	{ group = "CmpItemAbbrMatch",            fg = "green" },
	{ group = "CmpItemAbbrMatchFuzzy",       fg = "blue" },
	-- Custom groups
	-- default
	{ group = "CmpItemKindText",             fg = "white" },
	{ group = "CmpItemKindColor",            lk = "CmpItemKindText" },
	{ group = "CmpItemKindFile",             lk = "CmpItemKindText" },
	{ group = "CmpItemKindFolder",           lk = "CmpItemKindText" },
	{ group = "CmpItemKindEvent",            lk = "CmpItemKindText" },
	{ group = "CmpItemKindOperator",         lk = "CmpItemKindText" },
	{ group = "CmpItemKindTypeParameter",    lk = "CmpItemKindText" },
	-- Function - yellow
	{ group = "CmpItemKindFunction",         fg = "lyellow" },
	{ group = "CmpItemKindMethod",           lk = "CmpItemKindFunction" },
	{ group = "CmpItemKindConstructor",      lk = "CmpItemKindFunction" },
	{ group = "CmpItemKindModule",           lk = "CmpItemKindFunction" },
	{ group = "CmpItemKindSnippet",          lk = "CmpItemKindFunction" },
	-- Simple types - blue
	{ group = "CmpItemKindVariable",         fg = "lblue" },
	{ group = "CmpItemKindField",            lk = "CmpItemKindVariable" },
	{ group = "CmpItemKindReference",        lk = "CmpItemKindVariable" },
	{ group = "CmpItemKindConstant",         lk = "CmpItemKindVariable" },
	{ group = "CmpItemKindUnit",             lk = "CmpItemKindVariable" },
	{ group = "CmpItemKindValue",            lk = "CmpItemKindVariable" },
	{ group = "CmpItemKindKeyword",          lk = "CmpItemKindVariable" },
	-- Complex types - green
	{ group = "CmpItemKindClass",            fg = "lgreen" },
	{ group = "CmpItemKindInterface",        lk = "CmpItemKindClass" },
	{ group = "CmpItemKindProperty",         lk = "CmpItemKindClass" },
	{ group = "CmpItemKindEnumMember",       lk = "CmpItemKindClass" },
	{ group = "CmpItemKindEnum",             lk = "CmpItemKindClass" },
	{ group = "CmpItemKindStruct",           lk = "CmpItemKindClass" },

	-- LSP
	-- { group = "LspInlayHint",                lk = "lred" },

	-- Comments
	{ group = "@text.note",                  lk = "Todo" },
	{ group = "@text.todo",                  lk = "@text.note" },
	{ group = "@text.danger",                lk = "@text.note" },
	{ group = "@text.warning",               lk = "@text.note" },
	{ group = "@text.debug",                 lk = "@text.note" },
	{ group = "@text.uri",                   fg = "lblue" },
	{ group = "@comment.note",               lk = "@text.note" },
	{ group = "@comment.todo",               lk = "@text.todo" },
	{ group = "@comment.danger",             lk = "@text.danger" },
	{ group = "@comment.warning",            lk = "@text.warning" },
	{ group = "@comment.debug",              lk = "@text.debug" },
	{ group = "@comment.uri",                lk = "@text.uri" },
	{ group = "@string.special.url.comment", lk = "@text.uri" },
	{ group = "@text.uri.gitcommit",         lk = "@text.uri" },

	-- help
	{ group = "@markup.link.vimdoc",         lk = "@text.uri" },

	-- Obsidian
	{ group = "ObsidianTodo",                lk = "Todo" },
	{ group = "ObsidianDone",                fg = "lgreen" },
	{ group = "ObsidianImportant",           fg = "lred" },
	{ group = "ObsidianBullet",              lk = "Normal" },
	{ group = "ObsidianRefText",             lk = "@text.uri" },
	{ group = "ObsidianExtLinkIcon",         lk = "Error" },
	{ group = "ObsidianTag",                 lk = "ObsidianRefText" },
	{ group = "ObsidianBlockID",             lk = "ObsidianRefText" },
	{ group = "ObsidianHighlightText",       lk = "Error" },
}

-- Base16 color definition
local index = {
	black = 1,
	red = 2,
	green = 3,
	yellow = 4,
	blue = 5,
	magenta = 6,
	cyan = 7,
	white = 8,
	lblack = 9,
	lred = 10,
	lgreen = 11,
	lyellow = 12,
	lblue = 13,
	lmagenta = 14,
	lcyan = 15,
	lwhite = 16,
}
local colors = {
	"#1d1f21", "#cc342b", "#14b363", "#fba922", "#3971ed", "#b028e9", "#0abdae", "#c5c8c6",
	"#878988", "#c49c9a", "#93b6a4", "#c8b394", "#859acb", "#a884b8", "#7c9e9b", "#ffffff",
}

for i, color in ipairs(colors) do
	vim.g["terminal_color_" .. (i - 1)] = color
end

-- name to color
local n_to_c = function(name) return colors[index[name]] or "NONE" end

-- name to index
local n_to_i = function(name) return index[name] or "NONE" end

-- effects to map
local ef_to_map = function(ef)
	if type(ef) == "string" then ef = { ef } end
	if type(ef) == "nil" then ef = {} end

	local m = {}
	for _, e in pairs(ef) do
		m[e] = true
	end
	return m
end

-- highlight wrapper
for _, rule in pairs(rules) do
	local rule_map = {}

	if rule.lk == nil then
		rule_map = ef_to_map(rule.ef)
		rule_map.fg = n_to_c(rule.fg)
		rule_map.bg = n_to_c(rule.bg)
		rule_map.ctermfg = n_to_i(rule.fg)
		rule_map.ctermbg = n_to_i(rule.bg)
	else
		rule_map = { link = rule.lk }
	end

	vim.api.nvim_set_hl(0, rule.group, rule_map)
end
