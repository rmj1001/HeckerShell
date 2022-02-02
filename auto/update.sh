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

################################# LOGIC ########################################

[[ -x "$(command -v git)" ]] || { printf '%b\n' \
    'git must be installed.' && exit 1; }

# Source environment variables
wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto/env.sh |
    source /dev/stdin

cd "${DOTFILES_DOWN_DIR}" || { printf '%b\n' 'Dotfiles does not exist.' && exit 1; }

git pull
