" Useful function to get the current group
" :let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name')

" Save the Gruvbox colors for the Gui
"        0 black,  1 red,     2 green,   3 yellow,   4 blue,    5 magenta,   6 cyan,    7 white
"        8 lblack, 9 lred,    10 lgreen, 11 lyellow, 12 lblue,  13 lmagenta, 14 lcyan,  15 lwhite
let s:gui_colors = [
			\ '#1d1f21', '#cc342b', '#14b363', '#fba922',  '#3971ed', '#cc342b',   '#3971ed', '#c5c8c6',
			\ '#878988', '#cc342b', '#14b363', '#fba922',  '#3971ed', '#cc342b',   '#3971ed', '#ffffff'
			\ ]

" TODO: explore highlight groups
" see hi-link

" Wrapper to ease the highlight creation
" (will not impact the load time)
function! s:highlight_wrapper(hi)
	execute 'highlight ' .a:hi[0]               .
				\ ' term='     .a:hi[1]               .' cterm='   .a:hi[1]               .
				\ ' ctermfg='  .a:hi[2]               .' ctermbg=' .a:hi[3]               .
				\ ' guifg='    .s:gui_colors[a:hi[2]] .' guibg='   .s:gui_colors[a:hi[3]] .
				\ ' gui='      .a:hi[1]
endfunction

" Vim UI
"       Name,                       Effect,      FG,     BG
let s:highlights = [
			\ ['ColorColumn',             'NONE',      'NONE', 9],
			\ ['Conceal',                 'NONE',      15,     0],
			\ ['Cursor',                  'NONE',      0,      15],
			\ ['CursorColumn',            'reverse',   15,     0],
			\ ['CursorLine',              'bold',      15,     0],
			\ ['CursorLineNr',            'bold',      15,     0],
			\ ['Directory',               'NONE',      4,      0],
			\ ['DiffAdd',                 'NONE',      2,      0],
			\ ['DiffAdded',               'NONE',      2,      0],
			\ ['DiffChange',              'NONE',      4,      0],
			\ ['DiffDelete',              'NONE',      1,      0],
			\ ['DiffRemoved',             'NONE',      1,      0],
			\ ['DiffText',                'NONE',      3,      0],
			\ ['EndOfBuffer',             'NONE',      7,      0],
			\ ['Error',                   'NONE',      1,      0],
			\ ['ErrorMsg',                'NONE',      1,      0],
			\ ['FoldColumn',              'NONE',      7,      0],
			\ ['Folded',                  'NONE',      7,      0],
			\ ['LineNr',                  'NONE',      8,      0],
			\ ['LineNrAbove',             'NONE',      8,      0],
			\ ['LineNrBelow',             'NONE',      8,      0],
			\ ['MatchParen',              'NONE',      4,      0],
			\ ['ModeMsg',                 'NONE',      7,      0],
			\ ['MoreMsg',                 'NONE',      7,      0],
			\ ['NonText',                 'NONE',      7,      0],
			\ ['Normal',                  'NONE',      15,     0],
			\ ['Pmenu',                   'NONE',      7,      0],
			\ ['PmenuSbar',               'NONE',      7,      0],
			\ ['PmenuSel',                'bold',      15,     0],
			\ ['PmenuThumb',              'NONE',      0,      15],
			\ ['Question',                'NONE',      4,      0],
			\ ['QuickFixLine',            'NONE',      7,      0],
			\ ['Search',                  'NONE',      2,      0],
			\ ['IncSearch',               'NONE',      4,      0],
			\ ['SignColumn',              'NONE',      8,      0],
			\ ['SpecialKey',              'NONE',      8,      0],
			\ ['SpellBad',                'underline', 1,      0],
			\ ['SpellCap',                'underline', 1,      0],
			\ ['SpellLocal',              'underline', 1,      0],
			\ ['SpellRare',               'underline', 1,      0],
			\ ['StatusLine',              'NONE',      0,      7],
			\ ['StatusLineNC',            'NONE',      0,      8],
			\ ['StatusLineTerm',          'NONE',      0,      7],
			\ ['StatusLineTermNC',        'NONE',      0,      8],
			\ ['TabLine',                 'NONE',      8,      0],
			\ ['TabLineFill',             'NONE',      8,      0],
			\ ['TabLineSel',              'NONE',      0,      7],
			\ ['Title',                   'NONE',      0,      7],
			\ ['VertSplit',               'NONE',      0,      7],
			\ ['Visual',                  'reverse',   15,     0],
			\ ['WarningMsg',              'NONE',      3,      0],
			\ ['WildMenu',                'NONE',      7,      0],
			\ ['Menu',                    'NONE',      7,      0],
			\ ]

" Syntax
let s:highlights += [
			\ ['Boolean',                 'NONE',      15,     0],
			\ ['Character',               'NONE',      15,     0],
			\ ['Comment',                 'NONE',      8,      0],
			\ ['Conditional',             'NONE',      15,     0],
			\ ['Constant',                'NONE',      15,     0],
			\ ['Debug',                   'NONE',      15,     0],
			\ ['Define',                  'NONE',      15,     0],
			\ ['Delimiter',               'NONE',      15,     0],
			\ ['Directive',               'NONE',      15,     0],
			\ ['Exception',               'NONE',      15,     0],
			\ ['Float',                   'NONE',      15,     0],
			\ ['Format',                  'NONE',      15,     0],
			\ ['Function',                'NONE',      15,     0],
			\ ['Identifier',              'NONE',      15,     0],
			\ ['Ignore',                  'NONE',      1,      0],
			\ ['Include',                 'NONE',      15,     0],
			\ ['Keyword',                 'NONE',      15,     0],
			\ ['Label',                   'NONE',      15,     0],
			\ ['Macro',                   'NONE',      15,     0],
			\ ['Number',                  'NONE',      15,     0],
			\ ['Operator',                'NONE',      15,     0],
			\ ['PreCondit',               'NONE',      15,     0],
			\ ['PreProc',                 'NONE',      15,     0],
			\ ['Repeat',                  'NONE',      15,     0],
			\ ['Special',                 'NONE',      15,     0],
			\ ['SpecialChar',             'NONE',      15,     0],
			\ ['SpecialComment',          'NONE',      15,     0],
			\ ['Statement',               'NONE',      15,     0],
			\ ['StorageClass',            'NONE',      15,     0],
			\ ['String',                  'NONE',      15,     0],
			\ ['Structure',               'NONE',      15,     0],
			\ ['Tag',                     'NONE',      15,     0],
			\ ['Todo',                    'NONE',      3,      0],
			\ ['Type',                    'NONE',      15,     0],
			\ ['Typedef',                 'NONE',      15,     0],
			\ ['Underlined',              'NONE',      15,     0],
			\ ['htmlBold',                'NONE',      15,     0],
			\ ['htmlBoldUnderline',       'NONE',      15,     0],
			\ ['htmlBoldUnderlineItalic', 'NONE',      15,     0],
			\ ['htmlH1',                  'NONE',      15,     0],
			\ ['htmlH2',                  'NONE',      15,     0],
			\ ['htmlH3',                  'NONE',      15,     0],
			\ ['htmlH4',                  'NONE',      15,     0],
			\ ['htmlH5',                  'NONE',      15,     0],
			\ ['htmlH6',                  'NONE',      15,     0],
			\ ['htmlItalic',              'NONE',      15,     0],
			\ ['htmlTitle',               'NONE',      15,     0],
			\ ['htmlUnderline',           'NONE',      15,     0],
			\ ['htmlUnderlineItalic',     'NONE',      15,     0],
			\ ['markdownCode',            'NONE',      7,      0],
			\ ['markdownCodeBlock',       'NONE',      7,      0],
			\ ['markdownCodeDelimiter',   'NONE',      7,      0],
			\ ['markdownHeadingRule',     'NONE',      4,      0],
			\ ['markdownH1Delimiter',     'NONE',      4,      0],
			\ ['markdownH2Delimiter',     'NONE',      4,      0],
			\ ['markdownH3Delimiter',     'NONE',      4,      0],
			\ ['markdownH4Delimiter',     'NONE',      4,      0],
			\ ['markdownH5Delimiter',     'NONE',      4,      0],
			\ ['markdownH6Delimiter',     'NONE',      4,      0],
			\ ]

" Setup the colors
for hi in s:highlights
	call <SID>highlight_wrapper(hi)
endfor

" Name the current colorscheme
let g:colors_name = "mnml"
