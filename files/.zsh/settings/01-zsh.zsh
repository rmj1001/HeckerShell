#!/usr/bin/env zsh

# ZSH Options
setopt +o nomatch
setopt NO_HUP
zstyle ':completion:*' rehash true

# Plugins
export plugins=(
    doas
)
