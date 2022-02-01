#!/bin/zsh

# Syntax Highlighting
export SYNTAXHIGH="${SHELLFILES}/.syntaxhighlighting"

# Install syntax highlighting if the ~/.zsh/.syntaxhighlighting folder is missing
[[ ! -d "${SYNTAXHIGH}" ]] &&
    printf "%b\n" "Installing syntax highlighting...\n" &&
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${SYNTAXHIGH}" &&
    printf "%b\n" "" && read -s -k "?Press ENTER to continue." && clear

# Source syntax highlighting
source "${SYNTAXHIGH}"/zsh-syntax-highlighting.zsh

# Prompt
#export PS1='C:$(pwd | tr "////" "\\\\" ) > '
export PS1='[ ${USER}@${HOSTNAME} ] ${PWD} > '
export RPS1='$(date -u +"%m-%d-%Y %H:%M:%S")'

# History
export HISTFILE="${HOME}/.zsh-history"
export HISTSIZE=1000
export SAVEHIST=1000

# ZSH Options
setopt +o nomatch
setopt NO_HUP
setopt AUTO_CD
setopt AUTO_MENU
#setopt LIST_ROWS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST

# Ctrl ->
bindkey ';5C' forward-word

# Ctrl <-
bindkey ';5D' backward-word

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

fpath=("$HOME"/.local/share/zsh-completions/src $fpath)
autoload -U compinit && compinit

# Plugins
export plugins=(
    sudo
    backstreet
    curlapps
    russian-roulette
)
