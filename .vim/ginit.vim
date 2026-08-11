if !has('nvim')
  set toolbariconsize=tiny
endif

if filereadable('/mujbin/toggle-decorations.sh')
  au GUIEnter * silent !/mujbin/toggle-decorations.sh && /mujbin/maximize_current_window.sh
endif

set mousemodel=popup_setpos
set mouse=a
set guioptions=agitc
set titlestring=gvim
set termguicolors " for fzf colors

Font1
