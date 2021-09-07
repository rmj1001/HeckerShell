#!/usr/bin/env zsh

# Default Editor
[[ -f "$(command -v code)" ]] && export EDITOR="$(command -v code)"
[[ -f "$(command -v nano)" ]] && export EDITOR="$(command -v nano)"
[[ -f "$(command -v nvim)" ]] && export EDITOR="$(command -v nvim)"
[[ -f "$(command -v micro)" ]] && export EDITOR="$(command -v micro)"

# Default Browser
[[ -x "$(command -v firefox)" ]] && export BROWSER="$(command -v firefox)"

# Default Authentication
[[ -x "$(command -v sudo)" ]] && export AUTH="$(command -v sudo)"
[[ -x "$(command -v doas)" ]] && export AUTH="$(command -v doas)"

# ZSH
export ZSH="${HOME}/.zsh/.oh-my-zsh"
export ZSHRC="${HOME}/.zshrc"
export HISTFILE="${HOME}/.zsh-history"
export HISTSIZE=1000
export SAVEHIST=1000

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

# Trash
export TRASH="${XDG_DATA_HOME}/Trash/files"

# Environment Variables
export LANG="en_US.UTF-8"
export SNAPS="/snap/bin"
export GNUPGHOME="${HOME}/.gnupg"
export CARGO_HOME="${XDG_DATA_HOME}/cargo" # Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup" # Rust
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export ANDROID_HOME="${XDG_DATA_HOME}/android-sdk"
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql_history"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# User-defined PATH additions
export SYSTEM32="${HOME}/System32"
export BIN="${HOME}/.local/bin"
export APPIMAGES="${HOME}/Apps"
export GOPATH="${XDG_DATA_HOME}/go:${HOME}/Bin/projects/golang"
export CARGOPATH="${CARGO_HOME}/.cargo/bin" # Rust
export HOMEBREW="/home/linuxbrew/.linuxbrew/bin"
export DENO_INSTALL="/home/roy/.deno"

# Update PATH
export PATH=${PATH}:${SYSTEM32}:${SYSTEM32}:${BIN}:${APPIMAGES}:${GOPATH}/bin:${HOMEBREW}:${DENO_INSTALL}/bin

# Conditional PATH additions
[[ -z "${CARGOPATH}" ]] || export PATH="${PATH}:${CARGOPATH}"
