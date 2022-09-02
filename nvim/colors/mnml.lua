local rules = {
  -- Groups
  { group = "n4_default", fg= "lwhite" },

  -- Cursor
  { group = "Cursor",       ef = "reverse", },
  { group = "CursorColumn", lk = "cursor",  },
  { group = "CursorLine",   ef = "bold", fg = "lwhite", },
  { group = "CursorLineNr", lk = "CursorLine" },

  -- Diff
  { group = "DiffAdd",     fg = "green",      },
  { group = "DiffAdded",   lk = "DiffAdd"     },
  { group = "DiffChange",  fg = "blue",       },
  { group = "DiffDelete",  fg = "red",        },
  { group = "DiffRemoved", lk = "DiffDelete", },
  { group = "DiffText",    fg = "yellow",     },

  -- Fold
  { group = "Folded",     fg = "white",  },
  { group = "FoldColumn", lk = "Folded", },

  -- Search
  { group = "Search",    fg = "green", },
  { group = "IncSearch", fg = "blue",  },

  -- Spelling
  { group = "SpellBad",                ef = "underline",          fg = "red",    },
  { group = "SpellCap",                lk = "SpellBad"    },
  { group = "SpellLocal",              lk = "SpellBad"    },
  { group = "SpellRare",               lk = "SpellBad"    },

  -- Status line (Current & Not Current)
  { group = "StatusLine",       fg = "black", bg = "white" },
  { group = "StatusLineTerm",   lk = "StatusLineTerm" },
  { group = "StatusLineNC",     fg = "black", bg = "lblack" },
  { group = "StatusLineTermNC", lk = "StatusLineTermNC" },

  -- Tab Line
  { group = "TabLine",                 fg = "lblack",             },
  { group = "TabLineFill",             fg = "lblack",             },
  { group = "TabLineSel",              fg = "black",              bg = "white"   },
  { group = "Title",                   fg = "black",              bg = "white"   },
  { group = "VertSplit",               fg = "black",              bg = "white"   },

  -- Errors
  { group = "WarningMsg",              fg = "yellow" },
  { group = "Error",                   fg = "red", },
  { group = "ErrorMsg",                lk = "Error", },

  -- Misc
  { group = "Visual",       ef = "reverse" },
  { group = "LineNr",       fg = "lblack", },
  { group = "MatchParen",   fg = "blue",   },
  { group = "Directory",    fg = "blue",   },
  { group = "QuickFixLine", fg = "white",  },
  { group = "SignColumn",   fg = "lblack", },
  { group = "SpecialKey",   fg = "lblack", },

  -- Menu bar
  { group = "Menu",     fg = "white", },
  { group = "WildMenu", lk = "Menu"  },
  { group = "ModeMsg",  lk = "Menu", },
  { group = "MoreMsg",  lk = "Menu", },
  { group = "Question", fg = "blue",  },

  -- End of file / buffer
  { group = "NonText",  fg = "white", },
  { group = "EndOfBuffer", lk = "NonText", },

  -- Popup Menu
  { group = "Pmenu",      fg = "white", },
  { group = "PmenuSbar",  lk = "Pmenu", },
  { group = "PmenuSel",   ef = "bold",  fg = "lwhite", },
  { group = "PmenuThumb", fg = "black", bg = "lwhite"  },

  -- Syntax
  { group = "Boolean",        lk = "n4_default" },
  { group = "Character",      lk = "n4_default" },
  { group = "Comment",        fg = "lblack",    },
  { group = "Conceal",        lk = "n4_default" },
  { group = "Conditional",    lk = "n4_default" },
  { group = "Constant",       lk = "n4_default" },
  { group = "Debug",          lk = "n4_default" },
  { group = "Define",         lk = "n4_default" },
  { group = "Delimiter",      lk = "n4_default" },
  { group = "Directive",      lk = "n4_default" },
  { group = "Exception",      lk = "n4_default" },
  { group = "Float",          lk = "n4_default" },
  { group = "Format",         lk = "n4_default" },
  { group = "Function",       lk = "n4_default" },
  { group = "Identifier",     lk = "n4_default" },
  { group = "Ignore",         fg = "red",       },
  { group = "Include",        lk = "n4_default" },
  { group = "Keyword",        lk = "n4_default" },
  { group = "Label",          lk = "n4_default" },
  { group = "Macro",          lk = "n4_default" },
  { group = "Normal",         lk = "n4_default" },
  { group = "Number",         lk = "n4_default" },
  { group = "Operator",       lk = "n4_default" },
  { group = "PreCondit",      lk = "n4_default" },
  { group = "PreProc",        lk = "n4_default" },
  { group = "Repeat",         lk = "n4_default" },
  { group = "Special",        lk = "n4_default" },
  { group = "SpecialChar",    lk = "n4_default" },
  { group = "SpecialComment", lk = "n4_default" },
  { group = "Statement",      lk = "n4_default" },
  { group = "StorageClass",   lk = "n4_default" },
  { group = "String",         lk = "n4_default" },
  { group = "Structure",      lk = "n4_default" },
  { group = "Tag",            lk = "n4_default" },
  { group = "Todo",           fg = "yellow",    },
  { group = "Type",           lk = "n4_default" },
  { group = "Typedef",        lk = "n4_default" },
  { group = "Underlined",     lk = "n4_default" },

  -- HTML
  { group = "htmlBold",                lk = "n4_default" },
  { group = "htmlBoldUnderline",       lk = "n4_default" },
  { group = "htmlBoldUnderlineItalic", lk = "n4_default" },
  { group = "htmlH1",                  lk = "n4_default" },
  { group = "htmlH2",                  lk = "n4_default" },
  { group = "htmlH3",                  lk = "n4_default" },
  { group = "htmlH4",                  lk = "n4_default" },
  { group = "htmlH5",                  lk = "n4_default" },
  { group = "htmlH6",                  lk = "n4_default" },
  { group = "htmlItalic",              lk = "n4_default" },
  { group = "htmlTitle",               lk = "n4_default" },
  { group = "htmlUnderline",           lk = "n4_default" },
  { group = "htmlUnderlineItalic",     lk = "n4_default" },

  -- Markdown
  { group = "markdownCode",            fg = "white", },
  { group = "markdownCodeBlock",       lk = "markdownCode" },
  { group = "markdownCodeDelimiter",   lk = "markdownCode" },
  { group = "markdownHeadingRule",     fg = "blue", },
  { group = "markdownH1Delimiter",     lk = "markdownHeadingRule" },
  { group = "markdownH2Delimiter",     lk = "markdownHeadingRule" },
  { group = "markdownH3Delimiter",     lk = "markdownHeadingRule" },
  { group = "markdownH4Delimiter",     lk = "markdownHeadingRule" },
  { group = "markdownH5Delimiter",     lk = "markdownHeadingRule" },
  { group = "markdownH6Delimiter",     lk = "markdownHeadingRule" },
}

-- Base16 color definition

local index = { black = 1,  red = 2,   green = 3, yellow = 4, blue = 5,  magenta = 6, cyan = 7,  white = 8, lblack = 9, lred = 10, lgreen = 11, lyellow = 12, lblue = 13, lmagenta = 14, lcyan = 15, lwhite = 16 }
local colors = { "#1d1f21", "#cc342b", "#14b363", "#fba922",  "#3971ed", "#b028e9",   "#0abdae", "#c5c8c6", "#878988",  "#c49c9a", "#93b6a4",   "#c8b394",    "#859acb",  "#a884b8",     "#7c9e9b",  "#ffffff" }

-- name to color
local n_to_c = function(name)
  if name == 'NONE' then return 'NONE' end
  return colors[index[name]]
end

-- name to index
local n_to_i = function(name)
  if name == 'NONE' then return 'NONE' end
  return index[name]
end

-- highlight wrapper
for _, rule in pairs(rules) do
  if rule.ef == nil then rule.ef = 'NONE' end
  if rule.fg == nil then rule.fg = 'NONE' end
  if rule.bg == nil then rule.bg = 'NONE' end

  if rule.lk == nil then
    vim.cmd(
      "highlight! " .. rule.group ..
      " term="     .. rule.ef ..
      " cterm="    .. rule.ef ..
      " gui="      .. rule.ef ..
      " ctermfg="  .. n_to_i(rule.fg) ..
      " ctermbg="  .. n_to_i(rule.bg) ..
      " guifg="    .. n_to_c(rule.fg) ..
      " guibg="    .. n_to_c(rule.bg)
    )
  else
    vim.cmd("highlight! link " .. rule.group .. " " .. rule.lk)
  end
end

vim.cmd [[
  augroup color_auto_reload
    autocmd!
    autocmd BufWritePost mnml.lua source <afile>
  augroup end

  function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun
]]

vim.g.colors_name = "mnml"

-- Boolean                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Character                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- ColorColumn                             ctermbg=2 guibg=#cc342b
-- Comment                                 ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- Conceal                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Conditional                             ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Constant                                ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Cursor                                  ctermfg=1 ctermbg=16 guifg=#1d1f21 guibg=#ffffff
-- CursorColumn                            cterm=reverse ctermfg=16 ctermbg=1 gui=reverse guifg=#ffffff guibg=#1d1f21
-- CursorLine                              cterm=bold ctermfg=16 ctermbg=1 gui=bold guifg=#ffffff guibg=#1d1f21
-- CursorLineFold                          links to FoldColumn
-- CursorLineNr                            cterm=bold ctermfg=16 ctermbg=1 gui=bold guifg=#ffffff guibg=#1d1f21
-- CursorLineSign                          links to SignColumn
-- Debug                                   ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Define                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Delimiter                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- DiagnosticError                         ctermfg=1 guifg=Red
-- DiagnosticFloatingError                 links to DiagnosticError
-- DiagnosticFloatingHint                  links to DiagnosticHint
-- DiagnosticFloatingInfo                  links to DiagnosticInfo
-- DiagnosticFloatingWarn                  links to DiagnosticWarn
-- DiagnosticHint                          ctermfg=7 guifg=LightGrey
-- DiagnosticInfo                          ctermfg=4 guifg=LightBlue
-- DiagnosticSignError                     links to DiagnosticError
-- DiagnosticSignHint                      links to DiagnosticHint
-- DiagnosticSignInfo                      links to DiagnosticInfo
-- DiagnosticSignWarn                      links to DiagnosticWarn
-- DiagnosticUnderlineError                cterm=underline gui=underline guisp=Red
-- DiagnosticUnderlineHint                 cterm=underline gui=underline guisp=LightGrey
-- DiagnosticUnderlineInfo                 cterm=underline gui=underline guisp=LightBlue
-- DiagnosticUnderlineWarn                 cterm=underline gui=underline guisp=Orange
-- DiagnosticVirtualTextError              links to DiagnosticError
-- DiagnosticVirtualTextHint               links to DiagnosticHint
-- DiagnosticVirtualTextInfo               links to DiagnosticInfo
-- DiagnosticVirtualTextWarn               links to DiagnosticWarn
-- DiagnosticWarn                          ctermfg=3 guifg=Orange
-- DiffAdd                                 ctermfg=3 ctermbg=1 guifg=#14b363 guibg=#1d1f21
-- DiffAdded                               ctermfg=3 ctermbg=1 guifg=#14b363 guibg=#1d1f21
-- DiffChange                              ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- DiffDelete                              ctermfg=2 ctermbg=1 guifg=#cc342b guibg=#1d1f21
-- DiffRemoved                             ctermfg=2 ctermbg=1 guifg=#cc342b guibg=#1d1f21
-- DiffText                                ctermfg=4 ctermbg=1 guifg=#fba922 guibg=#1d1f21
-- Directive                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Directory                               ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- EndOfBuffer                             ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- Error                                   ctermfg=2 ctermbg=1 guifg=#cc342b guibg=#1d1f21
-- ErrorMsg                                ctermfg=2 ctermbg=1 guifg=#cc342b guibg=#1d1f21
-- Exception                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Float                                   ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- FloatBorder                             links to WinSeparator
-- FloatShadow                             guibg=Black blend=80
-- FloatShadowThrough                      guibg=Black blend=100
-- FoldColumn                              ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- Folded                                  ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- Format                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Function                                ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Identifier                              ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Ignore                                  ctermfg=2 ctermbg=1 guifg=#cc342b guibg=#1d1f21
-- IncSearch                               ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- Include                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Keyword                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Label                                   ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- LineNr                                  ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- LineNrAbove                             ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- LineNrBelow                             ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- LspInfoBorder                           links to Label
-- LspInfoFiletype                         links to Type
-- LspInfoList                             links to Function
-- LspInfoTip                              links to Comment
-- LspInfoTitle                            links to Title
-- Macro                                   ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- MatchParen                              ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- Menu                                    ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- Method                                  cleared
-- ModeMsg                                 ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- MoreMsg                                 ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- MsgArea                                 cleared
-- MsgSeparator                            links to StatusLine
-- NonText                                 ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- Normal                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- NormalFloat                             links to Pmenu
-- NormalNC                                cleared
-- Number                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- NvimAnd                                 links to NvimBinaryOperator
-- NvimArrow                               links to Delimiter
-- NvimAssignment                          links to Operator
-- NvimAssignmentWithAddition              links to NvimAugmentedAssignment
-- NvimAssignmentWithConcatenation         links to NvimAugmentedAssignment
-- NvimAssignmentWithSubtraction           links to NvimAugmentedAssignment
-- NvimAugmentedAssignment                 links to NvimAssignment
-- NvimBinaryMinus                         links to NvimBinaryOperator
-- NvimBinaryOperator                      links to NvimOperator
-- NvimBinaryPlus                          links to NvimBinaryOperator
-- NvimCallingParenthesis                  links to NvimParenthesis
-- NvimColon                               links to Delimiter
-- NvimComma                               links to Delimiter
-- NvimComparison                          links to NvimBinaryOperator
-- NvimComparisonModifier                  links to NvimComparison
-- NvimConcat                              links to NvimBinaryOperator
-- NvimConcatOrSubscript                   links to NvimConcat
-- NvimContainer                           links to NvimParenthesis
-- NvimCurly                               links to NvimSubscript
-- NvimDict                                links to NvimContainer
-- NvimDivision                            links to NvimBinaryOperator
-- NvimDoubleQuote                         links to NvimStringQuote
-- NvimDoubleQuotedBody                    links to NvimStringBody
-- NvimDoubleQuotedEscape                  links to NvimStringSpecial
-- NvimDoubleQuotedUnknownEscape           links to NvimInvalidValue
-- NvimEnvironmentName                     links to NvimIdentifier
-- NvimEnvironmentSigil                    links to NvimOptionSigil
-- NvimFigureBrace                         links to NvimInternalError
-- NvimFloat                               links to NvimNumber
-- NvimIdentifier                          links to Identifier
-- NvimIdentifierKey                       links to NvimIdentifier
-- NvimIdentifierName                      links to NvimIdentifier
-- NvimIdentifierScope                     links to NvimIdentifier
-- NvimIdentifierScopeDelimiter            links to NvimIdentifier
-- NvimInternalError                       ctermfg=9 ctermbg=9 guifg=Red guibg=Red
-- NvimInvalid                             links to Error
-- NvimInvalidAnd                          links to NvimInvalidBinaryOperator
-- NvimInvalidArrow                        links to NvimInvalidDelimiter
-- NvimInvalidAssignment                   links to NvimInvalid
-- NvimInvalidAssignmentWithAddition       links to NvimInvalidAugmentedAssignment
-- NvimInvalidAssignmentWithConcatenation  links to NvimInvalidAugmentedAssignment
-- NvimInvalidAssignmentWithSubtraction    links to NvimInvalidAugmentedAssignment
-- NvimInvalidAugmentedAssignment          links to NvimInvalidAssignment
-- NvimInvalidBinaryMinus                  links to NvimInvalidBinaryOperator
-- NvimInvalidBinaryOperator               links to NvimInvalidOperator
-- NvimInvalidBinaryPlus                   links to NvimInvalidBinaryOperator
-- NvimInvalidCallingParenthesis           links to NvimInvalidParenthesis
-- NvimInvalidColon                        links to NvimInvalidDelimiter
-- NvimInvalidComma                        links to NvimInvalidDelimiter
-- NvimInvalidComparison                   links to NvimInvalidBinaryOperator
-- NvimInvalidComparisonModifier           links to NvimInvalidComparison
-- NvimInvalidConcat                       links to NvimInvalidBinaryOperator
-- NvimInvalidConcatOrSubscript            links to NvimInvalidConcat
-- NvimInvalidContainer                    links to NvimInvalidParenthesis
-- NvimInvalidCurly                        links to NvimInvalidSubscript
-- NvimInvalidDelimiter                    links to NvimInvalid
-- NvimInvalidDict                         links to NvimInvalidContainer
-- NvimInvalidDivision                     links to NvimInvalidBinaryOperator
-- NvimInvalidDoubleQuote                  links to NvimInvalidStringQuote
-- NvimInvalidDoubleQuotedBody             links to NvimInvalidStringBody
-- NvimInvalidDoubleQuotedEscape           links to NvimInvalidStringSpecial
-- NvimInvalidDoubleQuotedUnknownEscape    links to NvimInvalidValue
-- NvimInvalidEnvironmentName              links to NvimInvalidIdentifier
-- NvimInvalidEnvironmentSigil             links to NvimInvalidOptionSigil
-- NvimInvalidFigureBrace                  links to NvimInvalidDelimiter
-- NvimInvalidFloat                        links to NvimInvalidNumber
-- NvimInvalidIdentifier                   links to NvimInvalidValue
-- NvimInvalidIdentifierKey                links to NvimInvalidIdentifier
-- NvimInvalidIdentifierName               links to NvimInvalidIdentifier
-- NvimInvalidIdentifierScope              links to NvimInvalidIdentifier
-- NvimInvalidIdentifierScopeDelimiter     links to NvimInvalidIdentifier
-- NvimInvalidLambda                       links to NvimInvalidParenthesis
-- NvimInvalidList                         links to NvimInvalidContainer
-- NvimInvalidMod                          links to NvimInvalidBinaryOperator
-- NvimInvalidMultiplication               links to NvimInvalidBinaryOperator
-- NvimInvalidNestingParenthesis           links to NvimInvalidParenthesis
-- NvimInvalidNot                          links to NvimInvalidUnaryOperator
-- NvimInvalidNumber                       links to NvimInvalidValue
-- NvimInvalidNumberPrefix                 links to NvimInvalidNumber
-- NvimInvalidOperator                     links to NvimInvalid
-- NvimInvalidOptionName                   links to NvimInvalidIdentifier
-- NvimInvalidOptionScope                  links to NvimInvalidIdentifierScope
-- NvimInvalidOptionScopeDelimiter         links to NvimInvalidIdentifierScopeDelimiter
-- NvimInvalidOptionSigil                  links to NvimInvalidIdentifier
-- NvimInvalidOr                           links to NvimInvalidBinaryOperator
-- NvimInvalidParenthesis                  links to NvimInvalidDelimiter
-- NvimInvalidPlainAssignment              links to NvimInvalidAssignment
-- NvimInvalidRegister                     links to NvimInvalidValue
-- NvimInvalidSingleQuote                  links to NvimInvalidStringQuote
-- NvimInvalidSingleQuotedBody             links to NvimInvalidStringBody
-- NvimInvalidSingleQuotedQuote            links to NvimInvalidStringSpecial
-- NvimInvalidSingleQuotedUnknownEscape    links to NvimInternalError
-- NvimInvalidSpacing                      links to ErrorMsg
-- NvimInvalidString                       links to NvimInvalidValue
-- NvimInvalidStringBody                   links to NvimStringBody
-- NvimInvalidStringQuote                  links to NvimInvalidString
-- NvimInvalidStringSpecial                links to NvimStringSpecial
-- NvimInvalidSubscript                    links to NvimInvalidParenthesis
-- NvimInvalidSubscriptBracket             links to NvimInvalidSubscript
-- NvimInvalidSubscriptColon               links to NvimInvalidSubscript
-- NvimInvalidTernary                      links to NvimInvalidOperator
-- NvimInvalidTernaryColon                 links to NvimInvalidTernary
-- NvimInvalidUnaryMinus                   links to NvimInvalidUnaryOperator
-- NvimInvalidUnaryOperator                links to NvimInvalidOperator
-- NvimInvalidUnaryPlus                    links to NvimInvalidUnaryOperator
-- NvimInvalidValue                        links to NvimInvalid
-- NvimLambda                              links to NvimParenthesis
-- NvimList                                links to NvimContainer
-- NvimMod                                 links to NvimBinaryOperator
-- NvimMultiplication                      links to NvimBinaryOperator
-- NvimNestingParenthesis                  links to NvimParenthesis
-- NvimNot                                 links to NvimUnaryOperator
-- NvimNumber                              links to Number
-- NvimNumberPrefix                        links to Type
-- NvimOperator                            links to Operator
-- NvimOptionName                          links to NvimIdentifier
-- NvimOptionScope                         links to NvimIdentifierScope
-- NvimOptionScopeDelimiter                links to NvimIdentifierScopeDelimiter
-- NvimOptionSigil                         links to Type
-- NvimOr                                  links to NvimBinaryOperator
-- NvimParenthesis                         links to Delimiter
-- NvimPlainAssignment                     links to NvimAssignment
-- NvimRegister                            links to SpecialChar
-- NvimSingleQuote                         links to NvimStringQuote
-- NvimSingleQuotedBody                    links to NvimStringBody
-- NvimSingleQuotedQuote                   links to NvimStringSpecial
-- NvimSingleQuotedUnknownEscape           links to NvimInternalError
-- NvimSpacing                             links to Normal
-- NvimString                              links to String
-- NvimStringBody                          links to NvimString
-- NvimStringQuote                         links to NvimString
-- NvimStringSpecial                       links to SpecialChar
-- NvimSubscript                           links to NvimParenthesis
-- NvimSubscriptBracket                    links to NvimSubscript
-- NvimSubscriptColon                      links to NvimSubscript
-- NvimTernary                             links to NvimOperator
-- NvimTernaryColon                        links to NvimTernary
-- NvimUnaryMinus                          links to NvimUnaryOperator
-- NvimUnaryOperator                       links to NvimOperator
-- NvimUnaryPlus                           links to NvimUnaryOperator
-- Operator                                ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Pmenu                                   ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- PmenuSbar                               ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- PmenuSel                                cterm=bold ctermfg=16 ctermbg=1 gui=bold guifg=#ffffff guibg=#1d1f21
-- PmenuThumb                              ctermfg=1 ctermbg=16 guifg=#1d1f21 guibg=#ffffff
-- PreCondit                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- PreProc                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Question                                ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- QuickFixLine                            ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- RedrawDebugClear                        ctermbg=11 guibg=Yellow
-- RedrawDebugComposed                     ctermbg=10 guibg=Green
-- RedrawDebugNormal                       cterm=reverse gui=reverse
-- RedrawDebugRecompose                    ctermbg=9 guibg=Red
-- Repeat                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Search                                  ctermfg=3 ctermbg=1 guifg=#14b363 guibg=#1d1f21
-- SignColumn                              ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- Special                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- SpecialChar                             ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- SpecialComment                          ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- SpecialKey                              ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- SpellBad                                cterm=underline ctermfg=2 ctermbg=1 gui=underline guifg=#cc342b guibg=#1d1f21 guisp=Red
-- SpellCap                                cterm=underline ctermfg=2 ctermbg=1 gui=underline guifg=#cc342b guibg=#1d1f21 guisp=Blue
-- SpellLocal                              cterm=underline ctermfg=2 ctermbg=1 gui=underline guifg=#cc342b guibg=#1d1f21 guisp=Cyan
-- SpellRare                               cterm=underline ctermfg=2 ctermbg=1 gui=underline guifg=#cc342b guibg=#1d1f21 guisp=Magenta
-- Statement                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- StatusLine                              ctermfg=1 ctermbg=8 guifg=#1d1f21 guibg=#c5c8c6
-- StatusLineNC                            ctermfg=1 ctermbg=9 guifg=#1d1f21 guibg=#878988
-- StatusLineTerm                          ctermfg=1 ctermbg=8 guifg=#1d1f21 guibg=#c5c8c6
-- StatusLineTermNC                        ctermfg=1 ctermbg=9 guifg=#1d1f21 guibg=#878988
-- StorageClass                            ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- String                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Struct                                  cleared
-- Structure                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Substitute                              links to Search
-- TabLine                                 ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- TabLineFill                             ctermfg=9 ctermbg=1 guifg=#878988 guibg=#1d1f21
-- TabLineSel                              ctermfg=1 ctermbg=8 guifg=#1d1f21 guibg=#c5c8c6
-- Tag                                     ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- TelescopeBorder                         links to TelescopeNormal
-- TelescopeMatching                       links to Special
-- TelescopeMultiIcon                      links to Identifier
-- TelescopeMultiSelection                 links to Type
-- TelescopeNormal                         links to Normal
-- TelescopePreviewBlock                   links to Constant
-- TelescopePreviewBorder                  links to TelescopeBorder
-- TelescopePreviewCharDev                 links to Constant
-- TelescopePreviewDate                    links to Directory
-- TelescopePreviewDirectory               links to Directory
-- TelescopePreviewExecute                 links to String
-- TelescopePreviewGroup                   links to Constant
-- TelescopePreviewHyphen                  links to NonText
-- TelescopePreviewLine                    links to Visual
-- TelescopePreviewLink                    links to Special
-- TelescopePreviewMatch                   links to Search
-- TelescopePreviewMessage                 links to TelescopePreviewNormal
-- TelescopePreviewMessageFillchar         links to TelescopePreviewMessage
-- TelescopePreviewNormal                  links to TelescopeNormal
-- TelescopePreviewPipe                    links to Constant
-- TelescopePreviewRead                    links to Constant
-- TelescopePreviewSize                    links to String
-- TelescopePreviewSocket                  links to Statement
-- TelescopePreviewSticky                  links to Keyword
-- TelescopePreviewTitle                   links to TelescopeTitle
-- TelescopePreviewUser                    links to Constant
-- TelescopePreviewWrite                   links to Statement
-- TelescopePromptBorder                   links to TelescopeBorder
-- TelescopePromptCounter                  links to NonText
-- TelescopePromptNormal                   links to TelescopeNormal
-- TelescopePromptPrefix                   links to Identifier
-- TelescopePromptTitle                    links to TelescopeTitle
-- TelescopeResultsBorder                  links to TelescopeBorder
-- TelescopeResultsClass                   links to Function
-- TelescopeResultsComment                 links to Comment
-- TelescopeResultsConstant                links to Constant
-- TelescopeResultsDiffAdd                 links to DiffAdd
-- TelescopeResultsDiffChange              links to DiffChange
-- TelescopeResultsDiffDelete              links to DiffDelete
-- TelescopeResultsDiffUntracked           links to NonText
-- TelescopeResultsField                   links to Function
-- TelescopeResultsFileIcon                links to Normal
-- TelescopeResultsFunction                links to Function
-- TelescopeResultsIdentifier              links to Identifier
-- TelescopeResultsLineNr                  links to LineNr
-- TelescopeResultsMethod                  links to Method
-- TelescopeResultsNormal                  links to TelescopeNormal
-- TelescopeResultsNumber                  links to Number
-- TelescopeResultsOperator                links to Operator
-- TelescopeResultsSpecialComment          links to SpecialComment
-- TelescopeResultsStruct                  links to Struct
-- TelescopeResultsTitle                   links to TelescopeTitle
-- TelescopeResultsVariable                links to SpecialChar
-- TelescopeSelection                      links to Visual
-- TelescopeSelectionCaret                 links to TelescopeSelection
-- TelescopeTitle                          links to TelescopeBorder
-- TermCursor                              cterm=reverse gui=reverse
-- TermCursorNC                            cleared
-- Title                                   ctermfg=1 ctermbg=8 guifg=#1d1f21 guibg=#c5c8c6
-- Todo                                    ctermfg=4 ctermbg=1 guifg=#fba922 guibg=#1d1f21
-- Type                                    ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Typedef                                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- Underlined                              ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- VertSplit                               ctermfg=1 ctermbg=8 guifg=#1d1f21 guibg=#c5c8c6
-- Visual                                  cterm=reverse ctermfg=16 ctermbg=1 gui=reverse guifg=#ffffff guibg=#1d1f21
-- VisualNC                                cleared
-- WarningMsg                              ctermfg=4 ctermbg=1 guifg=#fba922 guibg=#1d1f21
-- Whitespace                              links to NonText
-- WildMenu                                ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- WinSeparator                            links to VertSplit
-- htmlBold                                ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlBoldUnderline                       ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlBoldUnderlineItalic                 ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH1                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH2                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH3                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH4                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH5                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlH6                                  ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlItalic                              ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlTitle                               ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlUnderline                           ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- htmlUnderlineItalic                     ctermfg=16 ctermbg=1 guifg=#ffffff guibg=#1d1f21
-- lCursor                                 guifg=bg guibg=fg
-- markdownCode                            ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- markdownCodeBlock                       ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- markdownCodeDelimiter                   ctermfg=8 ctermbg=1 guifg=#c5c8c6 guibg=#1d1f21
-- markdownH1Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownH2Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownH3Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownH4Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownH5Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownH6Delimiter                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
-- markdownHeadingRule                     ctermfg=5 ctermbg=1 guifg=#3971ed guibg=#1d1f21
