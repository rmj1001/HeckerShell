#!/usr/bin/env bash

################################################################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: update.sh
#
#   Description:
#		Curl-able/wget-able updater for my dotfiles
################################################################################

################################# CONSTANTS ####################################

# Dotfiles urls
export DOTFILES_SITE_HTTPS="https://github.com/rmj1001/dotfiles.git"
export DOTFILES_SITE_SSH="git@github.com:rmj1001/dotfiles.git"
export DOTFILES_SITE="${DOTFILES_SITE_HTTPS}"

# Dotfiles directories
export DOTFILES_DOWN_DIR="${HOME}/.local/share"
export DOTFILES_DIR="${DOTFILES_DOWN_DIR}/dotfiles"
export DOTFILES="${DOTFILES_DIR}/files"

# OG Paths
export SYM_ZSHRC="${DOTFILES}/.zshrc"
export SYM_BASHRC="${DOTFILES}/.bashrc"
export SYM_SHELLFILES="${DOTFILES}/.shellfiles"
export SYM_SCRIPTS="${DOTFILES}/System32"

# Paths
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/System32"

function PRINT() { printf '%b\n' "${@}"; }

################################# LOGIC ########################################

[[ -x "$(command -v git)" ]] || { PRINT "" \
    'git must be installed.' && exit 1; }

cd "${DOTFILES_DIR}" || { PRINT 'Dotfiles does not exist.' && exit 1; }

# Confirm uninstallation
read -r -p \
    "Are you sure you want to update? Changes you made will be lost. (y/N) " \
    confirm

PRINT ""

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
    PRINT "Cancelling."
    exit 1
}

git pull
