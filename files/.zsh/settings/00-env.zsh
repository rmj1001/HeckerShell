#!/usr/bin/env zsh

# Editor
[[ -f "$(which code)" ]] && export EDITOR="$(which code)"
[[ -f "$(which nano)" ]] && export EDITOR="$(which nano)"
[[ -f "$(which nvim)" ]] && export EDITOR="$(which nvim)"
[[ -f "$(which micro)" ]] && export EDITOR="$(which micro)"

# Browser
[[ -x "$(which firefox)" ]] && export BROWSER="$(which firefox)"

# Authentication
[[ -x "$(which sudo)" ]] && export AUTH="$(which sudo)"
[[ -x "$(which doas)" ]] && export AUTH="$(which doas)"

# Default Applications
[[ -x "$(which tilix)" ]] && export TERMINAL="$(which tilix)"

# ZSH
export ZSH="${HOME}/.zsh/.oh-my-zsh"
export ZSHRC="${HOME}/.zshrc"
export HISTFILE="${HOME}/.zsh-history"

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

# Trash
export TRASH="${XDG_DATA_HOME}/Trash/files"

# Environment Variables
export LANG="en_US.UTF-8"
export SNAPS="/snap/bin"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME}/cargo" # Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup" # Rust
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export ANDROID_HOME="${XDG_DATA_HOME}/android-sdk"
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql_history"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# User-defined PATH additions
export SCRIPTS="${HOME}/.local/bin"
export APPIMAGES="${HOME}/Apps"
export GOPATH="${XDG_DATA_HOME}/go:${HOME}/Bin/projects/golang"
export CARGOPATH="${CARGO_HOME}/.cargo/bin" # Rust
export HOMEBREW="/home/linuxbrew/.linuxbrew/bin"
export DENO_INSTALL="/home/roy/.deno"

# Update PATH
export PATH=${PATH}:${SCRIPTS}:${APPIMAGES}:${GOPATH}/bin:${HOMEBREW}:${DENO_INSTALL}/bin

# Conditional PATH additions
[ -z "${CARGOPATH}" ] || export PATH="${PATH}:${CARGOPATH}"
