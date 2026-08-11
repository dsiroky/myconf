"==========================================================================

function! DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

"--------------------------------------------------------------------------

function! BufferDelete()
  if &modified
    echohl ErrorMsg
    echomsg "No write since last change. Not closing buffer."
    echohl NONE
  else
    let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if s:total_nr_buffers == 1
      bwipe
    else
      if bufnr("#") == -1
        bprevious
      else
        buffer #
      endif
      bwipe #
    endif
  endif
endfunction

"--------------------------------------------------------------------------

function! Autoformat_mail()
  " Assume that format options are meant for the body
  if !exists("b:body_format_options")
    let b:body_format_options=&l:fo
  endif

  " And that header should use the same format options without "aw"
  if !exists("b:header_format_options")
    let b:header_format_options = substitute( &l:fo, '[awt]', '', 'g' )
  endif

  " Only effective if editing headers, as indicated by "From:" on first line
  if getline(1) =~ '^From:'
    " Start off in the not-in-header state, so that initial format options
    " are not saved as header options
    if !exists('b:inheader')
      let b:inheader = 0
    endif

    " Check if currently in header section, by looking backwards for a
    " blank line.
    " Being on the separator is counted as being in the headers
    if search( '^$', 'bnW' )
      " currently in body, toggle if previously in headers
      if b:inheader
        let b:inheader = 0
        " Save current header format options to restore when returning
        let b:header_format_options = &l:fo
        let &l:fo = b:body_format_options
      endif
    else
      " Currently in the headers, toggle if previously in body
      if !b:inheader
        let b:inheader = 1
        " Save current body format options to restore when returning
        let b:body_format_options = &l:fo
        let &l:fo = b:header_format_options
      endif
    endif
  endif
endfunction

"--------------------------------------------------------------------------

function! ExploreWithHidden()
  "let s:cw = getcwd()
  "lcd %:p:h
  enew
  Explore
  "cd `=s:cw`
endfunction

"--------------------------------------------------------------------------

" /path/file.x:23
function! Yank_current_file_path_line()
  let l:buf = expand("%:p") . ":" . line(".")
  echo l:buf
  let @" = l:buf
  let @* = l:buf
  let @+ = l:buf
endfunction

"--------------------------------------------------------------------------

" file.x:23
function! Yank_current_file_path_line_partial()
  let l:proot = projectroot#guess()
  let l:buf = expand("%:p") . ":" . line(".")
  if l:buf[0:len(proot) - 1] == l:proot
    let l:buf = l:buf[len(proot) + 1:len(l:buf)]
  endif
  echo l:buf
  let @" = l:buf
  let @* = l:buf
  let @+ = l:buf
endfunction

"--------------------------------------------------------------------------

" turn scrolloff off for quickfix window
function! Set_scrolloff()
  if &buftype == 'quickfix'
    set scrolloff=0
  else
    set scrolloff=10
  endif
endfunction

"--------------------------------------------------------------------------

function! SavePost()
endfunction

function! SaveAll()
  wa
  call SavePost()
endfunction

"--------------------------------------------------------------------------

function! ToggleDiff()
    if &diff
        diffoff!
    else
        windo diffthis
    endif
endfunction

"--------------------------------------------------------------------------

function! FontIncrementSize()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
endfunction

"--------------------------------------------------------------------------

function! FontDecrementSize()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
endfunction

"--------------------------------------------------------------------------

" switch between horizontal and vertical splits
function! TurnSplit()
    if winwidth(0) < 200
        windo wincmd J
    else
        windo wincmd L
    endif
endfunction

"--------------------------------------------------------------------------

function! StatusLineFilename()
    return expand('%:p')
endfunction
