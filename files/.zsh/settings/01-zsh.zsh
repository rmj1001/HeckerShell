#!/usr/bin/env zsh

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

fpath=($HOME/.local/share/zsh-completions/src $fpath)
autoload -U compinit && compinit

# Plugins
export plugins=(
    sudo
)
