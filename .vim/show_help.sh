#!/bin/bash
FILETYPE=$1
SNIPPETSBULK=/tmp/vimsnippets
grep ^snippet ~/.vim/snippets_my/$FILETYPE.snippets > $SNIPPETSBULK
grep ^snippet ~/.vim/snippets_default/$FILETYPE.snippets >> $SNIPPETSBULK
gview -S ~/.vim/show_help.vim
