setlocal spell
setlocal formatoptions+=aw " automatic paragraph formatting
setlocal textwidth=72
setlocal omnifunc=QueryCommandComplete
"setlocal list

let g:qcc_query_command='~/.mutt/query_address.py %s ~/.mutt/aliases'
let g:qcc_multiline=1
let g:qcc_format_word="${0}"

hi clear ExtraWhitespace

autocmd CursorMoved,CursorMovedI <buffer> call Autoformat_mail()

" jump to first empty line
execute "normal gg/^$\<cr>"
