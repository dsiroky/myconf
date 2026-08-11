" vim: ft=vim
command! DiffSaved call g:DiffWithSaved()
command! -nargs=* Gr silent grep! <args> | botright copen 20
command! -nargs=* Grf silent grep! <args> % | botright copen 20
command! Showultisnips echo keys(UltiSnips#SnippetsInCurrentScope())
command! -nargs=1 -complete=file Cfile silent cfile! <args> | botright copen 20
command! TurnSplit call g:TurnSplit()

function! s:font1()
  GuiFont! Iosevka Term:h10
  set linespace=-2
endfunction

if has("nvim")
  command! Font1 call s:font1()
  " command! Fontprez execute "GuiFont! Inconsolata:style=Bold,stretch=SemiCondensed:h16" | set linespace=0
else
  command! Font1 set guifont=Iosevka\ Term\ 10|set linespace=-2
  command! Fontprez set guifont=Inconsolata\ Semi-Bold\ Semi-Condensed\ 16|set linespace=0
  command! Fontx set guifont=*
endif

command! HiGroup echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
