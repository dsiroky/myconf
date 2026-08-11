command! -nargs=+ Cppman silent! call system("chromium-browser 'https://duckduckgo.com/?sites=www.cppreference.com&q=" . expand(<q-args>) . "'")
nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>

command! FindImpl Gr "(\\b(struct\|class)\\b[^{]*:[^{]*\|public \|private \|protected )\\b<cword>\\b"
