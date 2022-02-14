#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: 03-sources.sh
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Dotfiles sourced settings
#
##############################################

######################################
### LANGUAGES
######################################

# NVM Variables
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export INIT="/usr/share/nvm/init-nvm.sh"

# NVM
# shellcheck disable=1091 disable=1090 # load nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
# shellcheck disable=1091 disable=1090 # nvm bash completions
[ -s "$NVM_DIR/bash_completion" ] && . "${NVM_DIR}/bash_completion"
# shellcheck disable=1091 disable=1090 # nvm initialize
[ -e "${INIT}" ] && . "${INIT}"

# Pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

[[ $(WHICH pyenv) ]] && eval "$(pyenv init -)"

# Rust
# shellcheck disable=1091 disable=1090
[[ -e "${CARGO_HOME}/env" ]] && . "${CARGO_HOME}/env"

######################################
### PACKAGE MANAGERS
######################################

### NIX ###

nixScript="${HOME}/.nix-profile/etc/profile.d/nix.sh"

if [[ -f "${nixScript}" ]]; then
    # shellcheck disable=1091 disable=1090
    . "${nixScript}"
fi

### HOMEBREW ###

# Prefix Locations
homePrefix=${HOME}/.linuxbrew
userPrefix=/home/linuxbrew/.linuxbrew

# Determine Homebrew Prefix
[[ -d "${homePrefix}" ]] && export BREW_PREFIX="${homePrefix}"
[[ -d "${userPrefix}" ]] && export BREW_PREFIX="${userPrefix}"

# Evaluate the homebrew prefix's shellenv if brew exists
[[ -z "${BREW_PREFIX}" ]] || eval "$(${BREW_PREFIX}/bin/brew shellenv)"

# shellcheck disable=1091 disable=1090 # Generated for envman. Do not edit.
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"

######################################
### VTE
######################################

# shellcheck disable=1091 disable=1090
[[ $TILIX_ID || $VTE_VERSION ]] && [[ -f "/etc/profile.d/vte.sh" ]] &&
    source "/etc/profile.d/vte.sh"
