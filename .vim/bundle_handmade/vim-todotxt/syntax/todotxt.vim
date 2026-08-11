if exists("b:current_syntax")
  finish
endif

syn match todotxtProject /\s+\S\+/
syn match todotxtContext /\s@\S\+/
syn match todotxtDate /\d\{4}-\d\{1,2}-\d\{1,2}/
syn region todotxtPri1 start="^(A) " end="$" contains=todotxtProject,todotxtContext,todotxtDate
syn region todotxtPri2 start="^(B) " end="$" contains=todotxtProject,todotxtContext,todotxtDate
syn region todotxtPri3 start="^(C) " end="$" contains=todotxtProject,todotxtContext,todotxtDate
syn region todotxtPri4 start="^([D-Z]) " end="$" contains=todotxtProject,todotxtContext,todotxtDate
syn region todotxtDone start="^x " end="$"

hi todotxtPri1 term=bold ctermfg=red guifg=#ff0000 gui=bold
hi todotxtPri2 term=bold ctermfg=yellow guifg=#ffb000 gui=bold
hi todotxtPri3 ctermfg=green guifg=#00c000
hi todotxtDone ctermfg=gray guifg=#c0c0c0
hi todotxtProject ctermfg=blue guifg=#0000ff
hi todotxtContext ctermfg=magenta guifg=#ff00ff
hi def link todotxtDate Constant

let b:current_syntax = "todotxt"
