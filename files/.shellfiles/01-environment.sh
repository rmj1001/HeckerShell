#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

################################## ENVIRONMENT #################################

# Default Editor
# (checks for each editor, if proceeding editor exists then default is changed)
[[ -f "$(WHICH nano)" ]] && EDITOR="$(WHICH nano)"
[[ -f "$(WHICH nvim)" ]] && EDITOR="$(WHICH nvim)"
[[ -f "$(WHICH code)" ]] && EDITOR="$(WHICH code)"
[[ -f "$(WHICH micro)" ]] && EDITOR="$(WHICH micro)"
export EDITOR

# Default Browser
[[ -x "$(WHICH firefox)" ]] && BROWSER="$(WHICH firefox)"
[[ -x "$(WHICH microsoft-edge)" ]] &&
    BROWSER="$(WHICH microsoft-edge)"
export BROWSER

# Default Authentication
# (sudo is default, if doas exists then it becomes default)
[[ -x "$(WHICH sudo)" ]] && AUTH="$(WHICH sudo)"
[[ -x "$(WHICH doas)" ]] && AUTH="$(WHICH doas)"
export AUTH

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

# Trash
export TRASH="${XDG_DATA_HOME}/Trash/files"

# Environment Variables
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LESSCHARSET="utf-8"
export SNAPS="/snap/bin"
export GNUPGHOME="${HOME}/.gnupg"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"   # Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup" # Rust
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export ANDROID_HOME="${XDG_DATA_HOME}/android-sdk"
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql_history"
export QT_QPA_PLATFORMTHEME="qt5ct"
export SSH_KEY_PATH="${HOME}/.ssh/id_rsa"

# GPG authorization
GPG_TTY="$(tty)"
export GPG_TTY

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# User Scripts/AppImages/Executables
export BIN="${HOME}/.local/bin"
export Scripts="${HOME}/Scripts"
export APPIMAGES="${HOME}/Apps"

# HeckerShell
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/Scripts"
export HECKERSHELL="${XDG_DATA_HOME}/HeckerShell"
export SHELL_TITLE="HeckerShell"

# Add heckershell scripts recursively to PATH
PATH="${SCRIPTS}:${PATH}:$(find "${SCRIPTS}"/* -maxdepth 1 -type d -printf ":%p")"

# Update PATH with AppImages
PATH="${PATH}:${BIN}:${APPIMAGES}"

# Developer Language Paths
export GOPATH="${XDG_DATA_HOME}/go:${HOME}/Bin/projects/golang"
export HOMEBREW="/home/linuxbrew/.linuxbrew/bin"
export DENO_INSTALL="/home/roy/.deno"
export FLATPAK_ENABLE_SDK_EXT=rust-stable,php74,openjdk,node16,mono6,dotnet,haskell,golang

# RUST lang paths
export RUSTUP_HOME="${HOME}/.local/share/rustup"
export CARGO_HOME="${HOME}/.local/share/cargo"
export RUST_BIN="${HOME}/.local/share/cargo/bin"

# FNM (node manager)
export FNM_MULTISHELL_PATH="/tmp/fnm_multishells/36217_1631124687204"
export FNM_DIR="/home/roy/.fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_ARCH="x64"

# Conditional PATH additions (Developer Languages)
[[ -z "${RUST_BIN}" ]] || PATH="${PATH}:${RUST_BIN}"
[[ -z "${GOPATH}" ]] || PATH="${PATH}:${GOPATH}/bin"
[[ -z "${HOMEBREW}" ]] || PATH="${PATH}:${HOMEBREW}"
[[ -z "${DENO_INSTALL}" ]] || PATH="${PATH}:${DENO_INSTALL}/bin"
[[ -z "${FNM_MULTISHELL_PATH}" ]] || PATH="${PATH}:${FNM_MULTISHELL_PATH}/bin"

export PATH

if [[ `uname` == "Darwin" ]]; then
	touch "${HOME}/.hushlogin"
fi
