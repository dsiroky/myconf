" vim: ft=vim

nmap <silent> <c-s-up> :call FontIncrementSize()<cr>
nmap <silent> <c-s-down> :call FontDecrementSize()<cr>

nmap ]b :bnext<cr>
nmap [b :bprevious<cr>
" buffer switch
nmap <leader>j <c-^>
" buffer choice
nmap <silent> <leader>bb :FzfBuffers<cr>
" close buffer
nmap <silent> <leader>bd <esc>:call BufferDelete()<cr>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <silent> ]t :tabnext<cr>
nmap <silent> [t :tabprev<cr>

" code completion
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-tab>"

" Y default is alias for yy
nmap Y y$

" indentation without loosing visual selection
vnoremap > >gv
vnoremap < <gv
" select last pasted text
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" better up/down on wrapped lines
nnoremap j gj
nnoremap k gk

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" remove all trailing whitespaces
nmap <silent> <leader>sp m`:%s/\s\+$//e<cr>``
nmap <silent> <leader>tr :call ExploreWithHidden()<CR>
nmap <silent> <leader>ta :Tagbar<CR>
" stop highlighting the current match
map <silent> <leader><space> :set hlsearch! hlsearch?<CR>
nmap <silent> <leader>fs :FSHere<cr>
nmap <silent> <leader>fo :FzfFiles<cr>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gD <Plug>(coc-declaration)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
inoremap <silent><expr> <S-TAB> coc#refresh()
nmap <silent> <leader>tp :call CocActionAsync('doHover')<CR>
map <silent> <leader>nu :set number!<cr>
map <silent> <leader>sc :setlocal spell!<cr>
map <leader>sl :setlocal spelllang=
map <leader>nf :Neoformat<cr>

nmap <silent> <leader>qo :botright copen 20<cr>
nmap <silent> <leader>qc :cclose<cr>
nmap ]q :cnext<cr>
nmap [q :cprevious<cr>
nmap <silent> <leader>lo :botright lopen 20<cr>
nmap <silent> <leader>lc :lclose<cr>
nmap ]l :lnext<cr>
nmap [l :lprevious<cr>

nmap <silent> <leader>wa :call SaveAll()<cr>
nmap <silent> <leader>mk :call SaveAll()<cr> :make! <bar> cwindow<cr>
nmap <silent> <leader>cff :call Yank_current_file_path_line()<cr>
nmap <silent> <leader>cfp :call Yank_current_file_path_line_partial()<cr>
" toggle wrapping
nmap <silent><expr> <f2> ':set wrap! go'.'-+'[&wrap]."=b\r"

" jump between conflicts in diff mode
if &diff
    nmap <silent> ]c :let lastsearch=@/<cr>/<<<<<<<<cr>:let @/=lastsearch<cr>
    nmap <silent> [c :let lastsearch=@/<cr>?<<<<<<<<cr>:let @/=lastsearch<cr>
    nmap <silent> <leader>td :call ToggleDiff()<cr>
endif

augroup kmaps
  " netrw double click
  au FileType netrw nmap <buffer> <2-leftmouse> <CR>

  au FileType cpp nmap <buffer> <silent> <leader>cp :call CppCopyMethodPrototype()<cr>
augroup END

map <F1> :silent exe "! ~/.vim/show_help.sh ".&filetype<cr>
vmap <F1> :silent exe "! ~/.vim/show_help.sh ".&filetype<cr>
imap <F1> <C-o><F1>

" ======== disabled keys

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <home> <nop>
noremap <end> <nop>
noremap <pagedown> <nop>
noremap <pageup> <nop>
noremap <del> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <home> <nop>
inoremap <end> <nop>
inoremap <pagedown> <nop>
inoremap <pageup> <nop>
inoremap <del> <nop>

" line undo
nnoremap U <nop>
" enter ex mode
nnoremap Q <nop>
" insert register
inoremap <C-r> <nop>

"##########################################################################
" some obscure and unneccessary shortcuts

" print highlight group under cursor
nmap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
