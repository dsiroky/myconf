" load settings per project

function! s:PerProjectSetupEnvironment(path)
  let l:perproject = ""

  if a:path =~ '/home/.*/Projects/firemni/mosaic'
    let l:perproject = 'mosaic'
  elseif a:path =~ '/home/.*/Projects/firemni/purestorage/work/.*/file-engine'
    let l:perproject = 'purestorage_file_engine'
  elseif a:path =~ '/home/.*/Projects/firemni/purestorage/work'
    let l:perproject = 'purestorage'
  elseif a:path =~ '/home/.*/Projects/firemni/lastminute/work/memsearch'
    let l:perproject = 'lastminute_memsearch'
  elseif a:path =~ '/home/.*/Projects/firemni/lastminute/work/staticdb'
    let l:perproject = 'lastminute_staticdb'
  elseif a:path =~ '/home/.*/Projects/backnocles'
    let l:perproject = 'backnocles'
  elseif a:path =~ '/home/.*/Projects/rewofs'
    let l:perproject = 'rewofs'
  endif

  if l:perproject != ""
    exec "source ~/.vim/perproject/" . l:perproject . ".vim"
  endif
endfunction

augroup perproject
  au!
  au BufReadPost,BufNewFile * call s:PerProjectSetupEnvironment(expand('%:p'))
augroup END

call s:PerProjectSetupEnvironment(getcwd())
