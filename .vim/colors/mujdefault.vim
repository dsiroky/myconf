hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mujdefault"

" ===========================================================

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

hi Normal guifg=#333333 guibg=#fcf1d0
hi NonText guifg=#a0a0ff
hi SpecialKey guifg=#a0a0ff

if has("nvim")
  hi StatusLine   guifg=none guibg=none
  hi StatusLineNC guifg=none guibg=none
endif

hi Comment      guifg=#b0b000 gui=none ctermfg=82
hi CommentH     guifg=#b0b000 gui=bold ctermfg=82
"hi CommentH     guifg=#73B5E4 gui=none ctermfg=82
hi Statement    guifg=#fc523f gui=none ctermfg=68
hi Constant     guifg=#808080 gui=none
hi SpecialChar  guifg=#8080ce gui=none
hi Identifier   guifg=#333333 gui=none
hi Function     guifg=#268bd2 gui=none
hi Type         guifg=#508830 gui=none
hi Preproc      guifg=#984098 gui=none
hi Title        guifg=#ff00ff gui=none
hi Special      guifg=#7b68ee gui=none

hi Visual       guibg=#d0d0d0

hi MatchParen guibg=#ffff50
hi Error        guifg=#fdf6f0 guibg=#fa5e3d
hi ErrorMsg     guifg=#fdf6f0 guibg=#fa5e3d

hi Pmenu      ctermfg=0 ctermbg=8 guibg=#dfd4b4
hi PmenuSel   ctermfg=0 ctermbg=13 guibg=#bdb394

hi VertSplit    guifg=#777777 guibg=#909090
hi LineNr       guifg=#a0a0a0 guibg=#f0f0f0 ctermbg=Black ctermfg=DarkGrey
hi CursorLine   guifg=NONE guibg=#f0f058 gui=NONE
hi CursorLineNr guifg=#c0c0c0 guibg=#f0f0f0 gui=bold ctermbg=Black ctermfg=DarkGrey
hi SignColumn   guifg=#6060c0 guibg=#e6e0d1 ctermbg=Black

hi Directory  guifg=DarkCyan

hi ColorColumn ctermbg=236 guibg=#fdf4d3

hi User1 gui=bold guifg=#ffa040 guibg=#222222 cterm=bold ctermfg=1
hi User2 gui=bold guifg=#dd3333 guibg=#222222 cterm=bold ctermfg=1
hi User3 gui=bold guifg=#ff66ff guibg=#222222 cterm=bold ctermfg=5
hi User4 gui=bold guifg=#a0ee40 guibg=#222222 cterm=bold ctermfg=2
hi User5 gui=bold guifg=#ddddff guibg=#222222 cterm=bold ctermfg=27

hi SpellCap ctermfg=21 ctermbg=NONE cterm=underline guisp=#9090ff
hi SpellBad ctermfg=64 ctermbg=NONE cterm=underline guisp=#ff9090
hi ExtraWhitespace  guibg=lightgreen ctermbg=darkgreen

" ===================

hi link cppModifier Statement

hi link pythonBuiltin type
hi link TagbarSignature function
hi link TagbarKind statement

hi link doxygenBriefL Comment
hi link doxygenBriefLine Comment
hi link doxygenComment2 Comment
hi link doxygenContinueComment Comment
hi link doxygenCommentL CommentH
hi link doxygenStart2 Comment
hi link doxygenStartL Comment
hi link doxygenSpecialOnelineDesc Comment
hi link doxygenSpecialMultilineDesc Comment
hi link doxygenHyperLink Comment
hi link doxygenParam CommentH
hi link doxygenParamName CommentH
hi link doxygenOther CommentH
hi link doxygenBOther CommentH
hi link doxygenSpecial CommentH
hi link doxygenParamName CommentH

hi EasyMotionShade guifg=#b0b0b0
hi link EasyMotionTarget2First EasyMotionTarget
hi link EasyMotionTarget2Second EasyMotionTarget

hi DiffText gui=none guifg=NONE guibg=#8cbee2
hi DiffChange gui=none guifg=NONE guibg=#acdef2
hi DiffDelete gui=none guifg=#ff8080 guibg=#ffe0d0
hi DiffAdd gui=none guifg=NONE guibg=#bafa9f

hi mailQuoted1 guifg=#787878 ctermfg=244
hi mailQuoted2 guifg=#787878 ctermfg=244

hi link markdownCode String

hi CocFadeOut guibg=NONE guifg=NONE gui=NONE
hi CocInfoFloat guifg=#555555 guibg=NONE
hi link CocWarningFloat CocInfoFloat
hi link CocErrorHighlight SpellBad
hi link CocWarningHighlight SpellCap
hi link CocInfoHighlight SpellLocal
hi link CocHintHighlight SpellRare
hi link CocMenuSel PmenuSel

" vim: sw=2
