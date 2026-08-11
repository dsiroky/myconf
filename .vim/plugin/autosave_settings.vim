let g:autosave_settings_file=expand("~/.vim/save/last_settings.vim")

function! Save_settings()
  " \ "set guifont=".substitute(&guifont, " ", "\\\\ ", "g")],
  call writefile(["set spelllang=".&spelllang],
                \ g:autosave_settings_file)
endfunction

augroup autosave_settings
  au!
  au VimLeavePre * call Save_settings()
augroup END

source ~/.vim/save/last_settings.vim
