# vim:set tabstop=4:

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup"
    setopt xtrace prompt_subst
fi

#########################################################################

autoload -Uz add-zsh-hook

#########################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.profile

#########################################################################

autoload -Uz colors
colors

eval "$(dircolors -b ~/.dir_colors)"

#########################################################################

setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY NO_NOMATCH
unsetopt SHARE_HISTORY GLOB_COMPLETE CASE_GLOB

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

ABBR_AUTOLOAD=0
ABBR_DEFAULT_BINDINGS=0
ABBR_QUIET=1

#########################################################################

# my "git co" is a multicommand - internal completion does not work
_git-co() {
    _git-checkout
}
_git-sw() {
    _git-switch
}

source ~/.antidote/antidote.zsh
antidote load

autoload -Uz compinit
compinit

LISTMAX=0
unsetopt LIST_AMBIGUOUS MENU_COMPLETE COMPLETE_IN_WORD
setopt AUTO_MENU AUTO_LIST LIST_PACKED

zstyle ':completion:*' menu select
# highlight next key for completion
zstyle -e ':completion:*:default' list-colors \
        'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==90=01}:${(s.:.)LS_COLORS}")'
# case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# make it faster
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' special-dirs true

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '\e' send-break

# with AUTO_LIST the prefix darkening does not work well, it darkens only the
# typed characters, not the full partial completed prefix.
# This is a workaround:
# https://www.reddit.com/r/zsh/comments/msps0/color_partial_tab_completions_in_zsh/c367xqo/
unambigandmenu() {
    echo -n "\e[31m...\e[0m"
    # avoid opening the list on the first expand
    unsetopt AUTO_LIST
    zle complete-word
    setopt AUTO_LIST
    zle magic-space
    zle backward-delete-char
    zle complete-word
    zle redisplay
}
zle -N unambigandmenu
bindkey -M viins "^i" unambigandmenu

if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

#########################################################################

autoload -Uz promptinit
promptinit
setopt PROMPT_SUBST

if [ -f "/usr/lib/git-core/git-sh-prompt" ]; then
    source /usr/lib/git-core/git-sh-prompt
else
    __git_ps1 () {
    }
fi
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1

if [ -z "$SSH_TTY" ]; then
    REMOTE_SESSION_COLOR=""
else
    REMOTE_SESSION_COLOR="%K{1}"
fi

if [ "$USER" == "root" ]; then
    PROMPT_PREFIX="#"
else
    PROMPT_PREFIX="▶"
fi

# there is a non-breakable space for "tagging" a previous prompt in a tmux scrollback
# (tmux shortcut `B)
PROMPT='
%F{234}%K{214}%n$REMOTE_SESSION_COLOR@%m:%K{39} %~ %k%F{8}$(__git_ps1 " \u2387 %s") %b%f%k
$PROMPT_PREFIX '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    precmd () {print -Pn "\e]0;%n@%m: %~\a"}
    ;;
*)
    ;;
esac

#########################################################################
# vi mode

bindkey -v

#----------------
# show different cursor in insert/command mode

cursor_thin () {
    # if [[ $TMUX = "" ]]; then
        printf "\033[6 q"
    # else
    #     printf "\033Ptmux;\033\033[6 q\033\\"
    # fi
}

cursor_thick () {
    # if [[ $TMUX = "" ]]; then
        printf "\033[2 q"
    # else
    #     printf "\033Ptmux;\033\033[2 q\033\\"
    # fi
}

zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        cursor_thick
    else
        cursor_thin
    fi
}
zle-line-init () {
    zle -K viins
    cursor_thin
}
zle -N zle-keymap-select
zle -N zle-line-init

function reset_cursor() {
    cursor_thick
}

add-zsh-hook preexec reset_cursor

#----------------

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

#----------------

yank="/mujbin/yank.sh"

function vi-delete-xsel {
    zle vi-delete
    echo "$CUTBUFFER" | $yank
}
zle -N vi-delete-xsel
bindkey -M vicmd 'd' vi-delete-xsel

function vi-yank-xsel {
    zle vi-yank
    echo "$CUTBUFFER" | $yank
}
zle -N vi-yank-xsel
bindkey -M vicmd 'y' vi-yank-xsel

function vi-put-xsel {
    CUTBUFFER=$(xsel -o -b </dev/null);
    zle vi-put-after
}
zle -N vi-put-xsel
bindkey -M vicmd 'p' vi-put-xsel

#----------------

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M viins '^v' edit-command-line
bindkey -M vicmd '^v' edit-command-line

bindkey -M viins '^p' up-history
bindkey -M viins '^n' down-history

#########################################################################
# Setup fzf
# ---------
# fzf is installed as the Ubuntu package; its shell integration (CTRL-T,
# CTRL-R, ALT-C key bindings + completion) is generated on the fly.
# The git browser (CTRL-G ...) comes from the junegunn/fzf-git.sh
# plugin, loaded above via antidote.
source <(fzf --zsh)

# zsh's vi-mode (bindkey -v, set earlier) binds bare ^G to list-expand
# in both viins and vicmd. With our very low KEYTIMEOUT (needed for a
# snappy ESC in vi-mode), that pre-existing binding wins the race
# against fzf-git.sh's ^G<letter> sequences: any human-speed gap
# between pressing ^G and the following key is enough for zsh to time
# out and fire list-expand instead of waiting for the fzf-git widget.
# Freeing bare ^G (same trick as the old bindkey -r '^T') removes the
# race entirely: with no binding to prematurely fire, zsh just waits
# for the rest of the sequence, regardless of KEYTIMEOUT.
bindkey -M viins -r '^G'
bindkey -M vicmd -r '^G'

export FZF_DEFAULT_OPTS="--reverse --height=30% -m"

#########################################################################
# Misc

# core dump
ulimit -c unlimited

source ~/.bash_aliases
bindkey "^Xa" _expand_alias

export KEYTIMEOUT=1
bindkey "^?" backward-delete-char
unsetopt AUTO_CD CORRECT CORRECT_ALL
setopt AUTO_PUSHD
umask 077

# split expanded variables by spaces
setopt SH_WORD_SPLIT

# disable non-vi movements/modificators (arrows, home, end, delete, ...)
bindkey -s '\e[1~' '\a'
bindkey -s '\e[2~' '\a'
bindkey -s '\e[3~' '\a'
bindkey -s '\e[4~' '\a'
bindkey -s '\eOA' '\a'
bindkey -s '\eOB' '\a'
bindkey -s '\eOC' '\a'
bindkey -s '\eOD' '\a'
bindkey -s '\e[A' '\a'
bindkey -s '\e[B' '\a'
bindkey -s '\e[C' '\a'
bindkey -s '\e[D' '\a'

eval "$(zoxide init --cmd=cd zsh)"

#########################################################################

# abbreviations whose expansion should be eval'd (command substitution
# result inserted) instead of inserted literally
typeset -gA ABBR_EVAL_ABBREVIATIONS=(
    cb 1
)

__abbr_expand_eval() {
    emulate -L zsh
    local -A reply
    abbr-expand-line "$LBUFFER" "$RBUFFER" || return
    if (( ${+ABBR_EVAL_ABBREVIATIONS[$reply[abbreviation]]} )); then
        local prefix=${reply[linput]%$reply[abbreviation]}
        LBUFFER="${prefix}$(eval "echo -n \"${reply[expansion]}\"")"
    else
        LBUFFER=$reply[loutput]
    fi
    [[ -n ${reply[routput]+x} ]] && RBUFFER=$reply[routput]
}
zle -N __abbr_expand_eval
bindkey "^ " __abbr_expand_eval

abbr -g gre='git rebase --onto='
abbr -g cb='$(git rev-parse --abbrev-ref HEAD)'

#########################################################################

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

#########################################################################

if [ -n "$SOURCE_EXTRA" ]; then
    source $SOURCE_EXTRA
fi

#########################################################################

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi
