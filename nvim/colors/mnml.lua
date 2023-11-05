local rules = {
  -- Groups
  { group = "n4_default",                fg = "lwhite" },

  -- Cursor
  { group = "Cursor",                    ef = "reverse" },
  { group = "CursorLine",                ef = "bold" },
  { group = "CursorLineNr",              fg = "lwhite",                  ef = "bold" },

  -- Diff
  { group = "DiffAdd",                   fg = "green" },
  { group = "DiffAdded",                 lk = "DiffAdd" },
  { group = "DiffChange",                fg = "blue" },
  { group = "DiffDelete",                fg = "red" },
  { group = "DiffRemoved",               lk = "DiffDelete" },
  { group = "DiffText",                  fg = "yellow" },

  -- Fold
  { group = "Folded",                    fg = "white" },
  { group = "FoldColumn",                lk = "Folded" },

  -- Search
  { group = "Search",                    fg = "green" },
  { group = "IncSearch",                 fg = "blue" },

  -- Spelling
  { group = "SpellBad",                  ef = "underline",               fg = "lred" },
  { group = "SpellCap",                  lk = "SpellBad" },
  { group = "SpellLocal",                lk = "SpellBad" },
  { group = "SpellRare",                 lk = "SpellBad" },

  -- Status line (Current & Not Current)
  { group = "StatusLine",                fg = "black",                   bg = "white" },
  { group = "StatusLineTerm",            lk = "StatusLineTerm" },
  { group = "StatusLineNC",              fg = "black",                   bg = "lblack" },
  { group = "StatusLineTermNC",          lk = "StatusLineTermNC" },
  { group = "WinSeparator",              bg = "lblack" },

  -- Tab Line
  { group = "TabLine",                   fg = "lblack" },
  { group = "TabLineFill",               fg = "lblack" },
  { group = "TabLineSel",                fg = "black",                   bg = "white" },
  { group = "VertSplit",                 fg = "black",                   bg = "white" },

  -- Errors
  { group = "WarningMsg",                fg = "lyellow" },
  { group = "Error",                     fg = "lred" },
  { group = "ErrorMsg",                  lk = "Error" },

  -- Misc
  { group = "Visual",                    ef = "reverse" },
  { group = "LineNr",                    fg = "lblack" },
  { group = "MatchParen",                fg = "blue" },
  { group = "Directory",                 fg = "blue" },
  { group = "QuickFixLine",              fg = "white" },
  { group = "SignColumn",                fg = "lblack" },
  { group = "SpecialKey",                fg = "lblack" },
  { group = "FloatBorder",               fg = "lblack" },
  { group = "Title",                     lk = "n4_default" },

  -- Menu bar
  { group = "Menu",                      fg = "white" },
  { group = "WildMenu",                  lk = "Menu" },
  { group = "ModeMsg",                   lk = "Menu" },
  { group = "MoreMsg",                   lk = "Menu" },
  { group = "Question",                  fg = "blue" },

  -- End of file / buffer
  { group = "NonText",                   fg = "white" },
  { group = "EndOfBuffer",               lk = "NonText" },

  -- Popup Menu
  { group = "Pmenu",                     lk = "n4_default" },
  { group = "PmenuSbar",                 lk = "Pmenu" },
  { group = "PmenuSel",                  ef = "reverse" },
  { group = "PmenuThumb",                fg = "black",                   bg = "lwhite" },

  -- Diagnosis
  { group = "DiagnosticError",           fg = "lred" },
  { group = "DiagnosticWarn",            fg = "lyellow" },
  { group = "DiagnosticInfo",            fg = "lblue" },
  { group = "DiagnosticHint",            fg = "lgreen" },
  { group = "DiagnosticOk",              fg = "lgreen" },
  { group = "DiagnosticUnnecessary",     fg = "lred" },
  { group = "DiagnosticUnderlineError",  ef = "underline",               fg = "lred" },
  { group = "DiagnosticUnderlineWarn",   ef = "underline",               fg = "lyellow" },
  { group = "DiagnosticUnderlineInfo",   ef = "underline",               fg = "lblue" },
  { group = "DiagnosticUnderlineHint",   ef = "underline",               fg = "lgreen" },
  { group = "DiagnosticUnderlineOk",     ef = "underline",               fg = "lgreen" },

  -- Syntax
  { group = "Boolean",                   lk = "n4_default" },
  { group = "Character",                 lk = "n4_default" },
  { group = "Comment",                   fg = "lblack" },
  { group = "Conceal",                   lk = "n4_default" },
  { group = "Conditional",               lk = "n4_default" },
  { group = "Constant",                  fg = "lgreen" },
  { group = "Debug",                     lk = "n4_default" },
  { group = "Define",                    lk = "n4_default" },
  { group = "Delimiter",                 lk = "n4_default" },
  { group = "Directive",                 lk = "n4_default" },
  { group = "Exception",                 lk = "n4_default" },
  { group = "Float",                     lk = "n4_default" },
  { group = "Format",                    lk = "n4_default" },
  { group = "Function",                  lk = "n4_default" },
  { group = "Identifier",                lk = "n4_default" },
  { group = "Ignore",                    fg = "red" },
  { group = "Include",                   lk = "n4_default" },
  { group = "Keyword",                   lk = "n4_default" },
  { group = "Label",                     lk = "n4_default" },
  { group = "Macro",                     lk = "n4_default" },
  { group = "Normal",                    lk = "n4_default" },
  { group = "Number",                    fg = "lgreen" },
  { group = "Operator",                  lk = "n4_default" },
  { group = "PreCondit",                 lk = "n4_default" },
  { group = "PreProc",                   lk = "n4_default" },
  { group = "Repeat",                    lk = "n4_default" },
  { group = "Special",                   lk = "n4_default" },
  { group = "SpecialChar",               lk = "n4_default" },
  { group = "SpecialComment",            lk = "n4_default" },
  { group = "Statement",                 lk = "n4_default" },
  { group = "StorageClass",              lk = "n4_default" },
  { group = "String",                    fg = "lgreen" },
  { group = "Structure",                 lk = "n4_default" },
  { group = "Tag",                       lk = "n4_default" },
  { group = "Todo",                      fg = "lyellow" },
  { group = "Type",                      lk = "n4_default" },
  { group = "Typedef",                   lk = "n4_default" },
  { group = "Underlined",                lk = "n4_default" },

  -- HTML
  { group = "htmlBold",                  lk = "n4_default" },
  { group = "htmlBoldUnderline",         lk = "n4_default" },
  { group = "htmlBoldUnderlineItalic",   lk = "n4_default" },
  { group = "htmlH1",                    lk = "n4_default" },
  { group = "htmlH2",                    lk = "n4_default" },
  { group = "htmlH3",                    lk = "n4_default" },
  { group = "htmlH4",                    lk = "n4_default" },
  { group = "htmlH5",                    lk = "n4_default" },
  { group = "htmlH6",                    lk = "n4_default" },
  { group = "htmlItalic",                lk = "n4_default" },
  { group = "htmlTitle",                 lk = "n4_default" },
  { group = "htmlUnderline",             lk = "n4_default" },
  { group = "htmlUnderlineItalic",       lk = "n4_default" },

  -- Markdown
  { group = "markdownCode",              fg = "white" },
  { group = "markdownCodeBlock",         lk = "markdownCode" },
  { group = "markdownCodeDelimiter",     lk = "markdownCode" },
  { group = "markdownHeadingRule",       fg = "blue" },
  { group = "markdownH1Delimiter",       lk = "markdownHeadingRule" },
  { group = "markdownH2Delimiter",       lk = "markdownHeadingRule" },
  { group = "markdownH3Delimiter",       lk = "markdownHeadingRule" },
  { group = "markdownH4Delimiter",       lk = "markdownHeadingRule" },
  { group = "markdownH5Delimiter",       lk = "markdownHeadingRule" },
  { group = "markdownH6Delimiter",       lk = "markdownHeadingRule" },

  -- C
  -- This shows a lot of red somehow :shrug:
  { group = "cErrInParen",               lk = "Delimiter" },
  { group = "cParenError",               lk = "Delimiter" },

  -- Git/Fugitive
  { group = "gitHashAbbrev",             fg = "lyellow" },
  { group = "fugitiveCount",             lk = "n4_default" },
  { group = "fugitiveStagedHeading",     fg = "lgreen" },
  { group = "fugitiveStagedModifier",    lk = "fugitiveStagedHeading" },
  { group = "fugitiveUnstagedHeading",   fg = "lblue" },
  { group = "fugitiveUnstagedModifier",  lk = "fugitiveUnstagedHeading" },
  { group = "fugitiveUntrackedHeading",  fg = "lyellow" },
  { group = "fugitiveUntrackedModifier", lk = "fugitiveUntrackedHeading" },

  -- Telescope
  { group = "TelescopeMatching",         lk = "Search" },

  -- nvim-cmp
  -- ref https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
  { group = "CmpItemAbbrDeprecated",     fg = "lblack",                  ef = "strikethrough" },
  { group = "CmpItemAbbrMatch",          fg = "green" },
  { group = "CmpItemAbbrMatchFuzzy",     fg = "blue" },
  -- Custom groups
  -- default
  { group = "CmpItemKindText",           fg = "white" },
  { group = "CmpItemKindColor",          lk = "CmpItemKindText" },
  { group = "CmpItemKindFile",           lk = "CmpItemKindText" },
  { group = "CmpItemKindFolder",         lk = "CmpItemKindText" },
  { group = "CmpItemKindEvent",          lk = "CmpItemKindText" },
  { group = "CmpItemKindOperator",       lk = "CmpItemKindText" },
  { group = "CmpItemKindTypeParameter",  lk = "CmpItemKindText" },
  -- Function - yellow
  { group = "CmpItemKindFunction",       fg = "lyellow" },
  { group = "CmpItemKindMethod",         lk = "CmpItemKindFunction" },
  { group = "CmpItemKindConstructor",    lk = "CmpItemKindFunction" },
  { group = "CmpItemKindModule",         lk = "CmpItemKindFunction" },
  { group = "CmpItemKindSnippet",        lk = "CmpItemKindFunction" },
  -- Simple types - blue
  { group = "CmpItemKindVariable",       fg = "lblue" },
  { group = "CmpItemKindField",          lk = "CmpItemKindVariable" },
  { group = "CmpItemKindReference",      lk = "CmpItemKindVariable" },
  { group = "CmpItemKindConstant",       lk = "CmpItemKindVariable" },
  { group = "CmpItemKindUnit",           lk = "CmpItemKindVariable" },
  { group = "CmpItemKindValue",          lk = "CmpItemKindVariable" },
  { group = "CmpItemKindKeyword",        lk = "CmpItemKindVariable" },
  -- Complex types - green
  { group = "CmpItemKindClass",          fg = "lgreen" },
  { group = "CmpItemKindInterface",      lk = "CmpItemKindClass" },
  { group = "CmpItemKindProperty",       lk = "CmpItemKindClass" },
  { group = "CmpItemKindEnumMember",     lk = "CmpItemKindClass" },
  { group = "CmpItemKindEnum",           lk = "CmpItemKindClass" },
  { group = "CmpItemKindStruct",         lk = "CmpItemKindClass" },

  -- Comments
  { group = "@text.note",                lk = "Todo" },
  { group = "@text.todo",                lk = "@text.note" },
  { group = "@text.danger",              lk = "@text.note" },
  { group = "@text.warning",             lk = "@text.note" },
  { group = "@text.debug",               lk = "@text.note" },
  { group = "@text.uri",                 fg = "lblue" },
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
  "#1d1f21",
  "#cc342b",
  "#14b363",
  "#fba922",
  "#3971ed",
  "#b028e9",
  "#0abdae",
  "#c5c8c6",
  "#878988",
  "#c49c9a",
  "#93b6a4",
  "#c8b394",
  "#859acb",
  "#a884b8",
  "#7c9e9b",
  "#ffffff",
}

-- name to color
local n_to_c = function(name)
  if name == "NONE" then
    return "NONE"
  end
  return colors[index[name]]
end

-- name to index
local n_to_i = function(name)
  if name == "NONE" then
    return "NONE"
  end
  return index[name]
end

-- highlight wrapper
for _, rule in pairs(rules) do
  -- TODO: redo with nvim_set_hl
  if rule.ef == nil then
    rule.ef = "NONE"
  end
  if rule.fg == nil then
    rule.fg = "NONE"
  end
  if rule.bg == nil then
    rule.bg = "NONE"
  end

  if rule.lk == nil then
    vim.cmd(
      "highlight! "
      .. rule.group
      .. " term="
      .. rule.ef
      .. " cterm="
      .. rule.ef
      .. " gui="
      .. rule.ef
      .. " ctermfg="
      .. n_to_i(rule.fg)
      .. " ctermbg="
      .. n_to_i(rule.bg)
      .. " guifg="
      .. n_to_c(rule.fg)
      .. " guibg="
      .. n_to_c(rule.bg)
      .. " guisp="
      .. n_to_c(rule.fg)
    )
  else
    vim.cmd("highlight! link " .. rule.group .. " " .. rule.lk)
  end
end

vim.cmd([[
  augroup color_auto_reload
  autocmd!
  autocmd BufWritePost mnml.lua source <afile>
  augroup end
]])

vim.g.colors_name = "mnml"
