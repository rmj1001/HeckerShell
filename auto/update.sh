#!/usr/bin/env bash

################################################################################
#   Author: Roy Conn
#   Project: Dotfiles
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

################################# LOGIC ########################################

[[ -x "$(command -v git)" ]] || { printf '%b\n' \
    'git must be installed.' && exit 1; }

cd "${DOTFILES_DIR}" || { printf '%b\n' 'Dotfiles does not exist.' && exit 1; }

git pull
