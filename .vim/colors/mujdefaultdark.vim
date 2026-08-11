hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mujdefault"

" ===========================================================

hi Normal guifg=#cccccc guibg=#342c28
hi NonText guifg=#5f5f00
hi SpecialKey guifg=#5f5f00

hi Comment      guifg=#b0b000 gui=italic ctermfg=82
hi Statement    guifg=#fc523f gui=none ctermfg=68
hi Constant     guifg=#808080 gui=none
hi SpecialChar  guifg=#8080ce gui=none
hi Identifier   guifg=#cccccc gui=none
hi Function     guifg=#268bd2 gui=none
hi Type         guifg=#508830 gui=none
hi Preproc      guifg=#984098 gui=none
hi Title        guifg=#ff00ff gui=none
hi Special      guifg=#7b68ee gui=none

hi MatchParen guibg=#707000
hi Error        guifg=#fdf6f0 guibg=#fa5e3d
hi ErrorMsg     guifg=#fdf6f0 guibg=#fa5e3d

hi Pmenu      ctermfg=0 ctermbg=8 guibg=#b0b0b0
hi PmenuSel   ctermfg=0 ctermbg=13 guibg=#ffff78

hi LineNr       guifg=#c0c0c0 guibg=#0f0f0f ctermbg=Black ctermfg=DarkGrey
hi CursorLineNr guifg=#c0c0c0 guibg=#0f0f0f gui=bold ctermbg=Black ctermfg=DarkGrey
hi SignColumn   guifg=#6060c0 guibg=#1f1f1f ctermbg=Black
hi SyntasticErrorSign guifg=#fdf6f0 guibg=#cc725f
hi SyntasticWarningSign guifg=#a0a0a0 guibg=#404000

hi Directory  guifg=DarkCyan

hi ColorColumn ctermbg=80 guibg=#282828

hi mailQuoted1 guifg=#787878
hi mailQuoted2 guifg=#787878

hi User1 gui=bold guifg=#ffa040 guibg=#222222 cterm=bold ctermfg=1
hi User2 gui=bold guifg=#dd3333 guibg=#222222 cterm=bold ctermfg=1
hi User3 gui=bold guifg=#ff66ff guibg=#222222 cterm=bold ctermfg=5
hi User4 gui=bold guifg=#a0ee40 guibg=#222222 cterm=bold ctermfg=2
hi User5 gui=bold guifg=#ddddff guibg=#222222 cterm=bold ctermfg=27

hi SpellCap ctermfg=21 ctermbg=NONE cterm=underline guisp=#9090ff
hi SpellBad ctermfg=64 ctermbg=NONE cterm=underline guisp=#ff9090
hi ExtraWhitespace  guibg=lightgreen ctermbg=darkgreen

" ===================

hi link pythonBuiltin type
hi link TagbarSignature function
hi link TagbarKind statement

" vim: sw=2
