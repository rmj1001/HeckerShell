#!/usr/bin/env zsh

# Default Editor (checks for each editor, if proceeding editor exists then default is changed)
[[ -f "$(command -v nano)" ]] && export EDITOR="$(command -v nano)"
[[ -f "$(command -v nvim)" ]] && export EDITOR="$(command -v nvim)"
[[ -f "$(command -v micro)" ]] && export EDITOR="$(command -v micro)"
[[ -f "$(command -v code)" ]] && export EDITOR="$(command -v code)"

# Default Browser
[[ -x "$(command -v firefox)" ]] && export BROWSER="$(command -v firefox)"

# Default Authentication (sudo is default, if doas exists then it becomes default)
[[ -x "$(command -v sudo)" ]] && export AUTH="$(command -v sudo)"
[[ -x "$(command -v doas)" ]] && export AUTH="$(command -v doas)"

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

# User Scripts/AppImages
export SYSTEM32="${HOME}/System32"
export SCRIPTS="${SYSTEM32}"
export BIN="${HOME}/.local/bin"
export APPIMAGES="${HOME}/Apps"

# Update PATH with script paths and AppImages
export PATH=${PATH}:${SYSTEM32}:${BIN}:${APPIMAGES}

# Developer Language Paths
export GOPATH="${XDG_DATA_HOME}/go:${HOME}/Bin/projects/golang"
export CARGOPATH="${CARGO_HOME}/.cargo/bin" # Rust
export HOMEBREW="/home/linuxbrew/.linuxbrew/bin"
export DENO_INSTALL="/home/roy/.deno"

export FNM_MULTISHELL_PATH="/tmp/fnm_multishells/36217_1631124687204"
export FNM_DIR="/home/roy/.fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_ARCH="x64"

# Conditional PATH additions (Developer Languages)
[[ -z "${CARGOPATH}" ]] || export PATH="${PATH}:${CARGOPATH}"
[[ -z "${GOPATH}" ]] || export PATH="${PATH}:${GOPATH}/bin"
[[ -z "${HOMEBREW}" ]] || export PATH="${PATH}:${HOMEBREW}"
[[ -z "${DENO_INSTALL}" ]] || export PATH="${PATH}:${DENO_INSTALL}/bin"
[[ -z "${FNM_MULTISHELL_PATH}" ]] || export PATH="${PATH}:${FNM_MULTISHELL_PATH}/bin"
