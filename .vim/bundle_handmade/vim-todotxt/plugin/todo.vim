if exists("g:loaded_todo")
  finish
endif
let g:loaded_todo = 1

python3 << ENDPYTHON

import functools
import vim

def cmp(a, b):
    return (a > b) - (a < b)

def cmp_todo(l1, l2):
    if l1.startswith("x "):
        return 1
    if l2.startswith("x "):
        return -1
    return cmp(l1, l2)

def sort_todo():
    lines = list(vim.current.buffer)
    lines.sort(key=functools.cmp_to_key(cmp_todo))
    vim.current.buffer[:] = lines

ENDPYTHON

function! SortTodo()
python3 << ENDPYTHON
sort_todo()
ENDPYTHON
endfunction

command! SortTodo :call SortTodo()

augroup vimtodo
  "au BufWritePre TODO.txt SortTodo
augroup END
