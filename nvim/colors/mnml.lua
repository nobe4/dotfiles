local groups = {
  -- Vim UI
  { group  = "ColorColumn",             ef = "NONE",      fg = "NONE",   bg = "lred"   },
  { group  = "Conceal",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Cursor",                  ef = "NONE",      fg = "black",  bg = "lwhite" },
  { group  = "CursorColumn",            ef = "reverse",   fg = "lwhite", bg = "black"  },
  { group  = "CursorLine",              ef = "bold",      fg = "lwhite", bg = "black"  },
  { group  = "CursorLineNr",            ef = "bold",      fg = "lwhite", bg = "black"  },
  { group  = "Directory",               ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "DiffAdd",                 ef = "NONE",      fg = "green",  bg = "black"  },
  { group  = "DiffAdded",               ef = "NONE",      fg = "green",  bg = "black"  },
  { group  = "DiffChange",              ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "DiffDelete",              ef = "NONE",      fg = "red",    bg = "black"  },
  { group  = "DiffRemoved",             ef = "NONE",      fg = "red",    bg = "black"  },
  { group  = "DiffText",                ef = "NONE",      fg = "yellow", bg = "black"  },
  { group  = "EndOfBuffer",             ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "Error",                   ef = "NONE",      fg = "red",    bg = "black"  },
  { group  = "ErrorMsg",                ef = "NONE",      fg = "red",    bg = "black"  },
  { group  = "FoldColumn",              ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "Folded",                  ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "LineNr",                  ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "LineNrAbove",             ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "LineNrBelow",             ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "MatchParen",              ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "ModeMsg",                 ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "MoreMsg",                 ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "NonText",                 ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "Normal",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Pmenu",                   ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "PmenuSbar",               ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "PmenuSel",                ef = "bold",      fg = "lwhite", bg = "black"  },
  { group  = "PmenuThumb",              ef = "NONE",      fg = "black",  bg = "lwhite" },
  { group  = "Question",                ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "QuickFixLine",            ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "Search",                  ef = "NONE",      fg = "green",  bg = "black"  },
  { group  = "IncSearch",               ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "SignColumn",              ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "SpecialKey",              ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "SpellBad",                ef = "underline", fg = "red",    bg = "black"  },
  { group  = "SpellCap",                ef = "underline", fg = "red",    bg = "black"  },
  { group  = "SpellLocal",              ef = "underline", fg = "red",    bg = "black"  },
  { group  = "SpellRare",               ef = "underline", fg = "red",    bg = "black"  },
  { group  = "StatusLine",              ef = "NONE",      fg = "black",  bg = "white"  },
  { group  = "StatusLineNC",            ef = "NONE",      fg = "black",  bg = "lblack" },
  { group  = "StatusLineTerm",          ef = "NONE",      fg = "black",  bg = "white"  },
  { group  = "StatusLineTermNC",        ef = "NONE",      fg = "black",  bg = "lblack" },
  { group  = "TabLine",                 ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "TabLineFill",             ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "TabLineSel",              ef = "NONE",      fg = "black",  bg = "white"  },
  { group  = "Title",                   ef = "NONE",      fg = "black",  bg = "white"  },
  { group  = "VertSplit",               ef = "NONE",      fg = "black",  bg = "white"  },
  { group  = "Visual",                  ef = "reverse",   fg = "lwhite", bg = "black"  },
  { group  = "WarningMsg",              ef = "NONE",      fg = "yellow", bg = "black"  },
  { group  = "WildMenu",                ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "Menu",                    ef = "NONE",      fg = "white",  bg = "black"  },
  -- Syntax
  { group  = "Boolean",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Character",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Comment",                 ef = "NONE",      fg = "lblack", bg = "black"  },
  { group  = "Conditional",             ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Constant",                ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Debug",                   ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Define",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Delimiter",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Directive",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Exception",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Float",                   ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Format",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Function",                ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Identifier",              ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Ignore",                  ef = "NONE",      fg = "red",    bg = "black"  },
  { group  = "Include",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Keyword",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Label",                   ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Macro",                   ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Number",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Operator",                ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "PreCondit",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "PreProc",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Repeat",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Special",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "SpecialChar",             ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "SpecialComment",          ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Statement",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "StorageClass",            ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "String",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Structure",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Tag",                     ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Todo",                    ef = "NONE",      fg = "yellow", bg = "black"  },
  { group  = "Type",                    ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Typedef",                 ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "Underlined",              ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlBold",                ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlBoldUnderline",       ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlBoldUnderlineItalic", ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH1",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH2",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH3",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH4",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH5",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlH6",                  ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlItalic",              ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlTitle",               ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlUnderline",           ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "htmlUnderlineItalic",     ef = "NONE",      fg = "lwhite", bg = "black"  },
  { group  = "markdownCode",            ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "markdownCodeBlock",       ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "markdownCodeDelimiter",   ef = "NONE",      fg = "white",  bg = "black"  },
  { group  = "markdownHeadingRule",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH1Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH2Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH3Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH4Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH5Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
  { group  = "markdownH6Delimiter",     ef = "NONE",      fg = "blue",   bg = "black"  },
}

-- Base16 color definition
local index  = { "black",   "red",     "green",   "yellow",  "blue",    "magenta", "cyan",    "white",   "lblack",  "lred",    "lgreen",  "lyellow", "lblue",   "lmagenta", "lcyan",   "lwhite",  }
local colors = { "#1d1f21", "#cc342b", "#14b363", "#fba922", "#3971ed", "#cc342b", "#3971ed", "#c5c8c6", "#878988", "#cc342b", "#14b363", "#fba922", "#3971ed", "#cc342b",  "#3971ed", "#ffffff", }

-- name to color
local n_to_c = function(name)
  if name == 'NONE' then return 'NONE' end

  for i, v in ipairs(index) do
    if v == name then return colors[i] end
  end
  return nil
end

-- name to index
local n_to_i = function(name)
  if name == 'NONE' then return 'NONE' end

  for i, v in ipairs(index) do
    if v == name then return i end
  end
  return nil
end

-- highlight wrapper
local h = function(args)
  if args.ef == nil then args.ef = 'NONE' end
  if args.fg == nil then args.fg = 'NONE' end
  if args.bg == nil then args.bg = 'NONE' end

  vim.cmd(
    "highlight " .. args.group ..
    " term="     .. args.ef ..
    " cterm="    .. args.ef ..
    " gui="      .. args.ef ..
    " ctermfg="  .. n_to_i(args.fg) ..
    " ctermbg="  .. n_to_i(args.bg) ..
    " guifg="    .. n_to_c(args.fg) ..
    " guibg="    .. n_to_c(args.bg)
  )
end

for _, group in pairs(groups) do
  h(group)
end

vim.g.colors_name = "mnml"
