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

DOTFILES_DOWN_DIR="${HOME}/.local/share/dotfiles"

################################# LOGIC ########################################

[[ -x "$(command -v)" ]] || printf '%b\n' \
    'git must be installed.' && exit 1

cd "${DOTFILES_DOWN_DIR}" || printf '%b\n' 'Dotfiles does not exist.' && exit 1

git pull
