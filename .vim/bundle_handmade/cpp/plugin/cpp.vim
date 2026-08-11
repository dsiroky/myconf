if !has('python3')
  echo "Error: Required vim compiled with +python3"
  finish
endif

" --------------------------------
" Add our plugin to the path
" --------------------------------
python3 << endOfPython
import sys
import vim
sys.path.append(vim.eval('expand("<sfile>:h")'))
endOfPython

" --------------------------------
"  Function(s)
" --------------------------------
function! CppCopyMethodPrototype()
python3 << endOfPython
from classes import full_prototype
cursor = vim.current.window.cursor
# vim rows and cols are zero based indexes
p = full_prototype(vim.current.buffer, (cursor[0] - 1, cursor[1] - 1))
print("copied")
vim.command("call setreg(\"+\", \"%s\n\")" % p.replace("\"", "\\\""))
endOfPython
endfunction
