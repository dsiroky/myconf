# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.profile

###########################################################################

COLOR_DIM='\[\e[90m\]'
COLOR_LWHITE='\[\e[97m\]'
COLOR_CYAN='\[\e[36m\]'
COLOR_LCYAN='\[\e[96m\]'
COLOR_YELLOW='\[\e[93m\]'
COLOR_END='\[\e[0m\]'

eval "$(dircolors -b ~/.dir_colors)"

###########################################################################

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

umask 077

# completion - show suffixes
bind 'set colored-completion-prefix On'

# core dump
ulimit -c unlimited

#########################################################################

# git_prompt_additions()
# {
#   echo "$(__git_ps1 | sed -e 's/^ *//' -e 's/ *$//')"
# }
#
# if [ "`id -u`" -eq 0 ]; then
#   LOGINCOLOR="$COLOR_YELLOW"
#   LOGINMARK="#"
# else
#   LOGINCOLOR="$COLOR_CYAN"
#   LOGINMARK="▶"
#   #LOGINMARK="$"
# fi
# PS1="\n$LOGINCOLOR${debian_chroot:+($debian_chroot)}\u@\h:$COLOR_LWHITE\w$COLOR_DIM\n\$(git_prompt_additions)$COLOR_END$LOGINMARK "
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWCOLORHINTS=1

###########################################################################

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#########################################################################

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
