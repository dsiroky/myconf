" ==== custom literals ====

syn match	cFloat		display contained "\d\+f\(\w*\)"
"floating point number, with dot, optional exponent
syn match	cFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=\(\w*\)"
"floating point number, starting with a dot, optional exponent
syn match	cFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=\(\w*\)\>"
"floating point number, without dot, with exponent
syn match	cFloat		display contained "\d\+e[-+]\=\d\+\(\w*\)\>"

syn match cppNumber		display "\<0b[01]\('\=[01]\+\)*\(\w*\)\>"
syn match cppNumber		display "\<[0-9]\('\=\d\+\)*\(\w*\)\>" contains=cFloat
syn match cppNumber		display "\<0x\x\('\=\x\+\)*\(\w*\)\>"
