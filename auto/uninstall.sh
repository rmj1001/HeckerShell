#!/usr/bin/env bash

################################################################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: Dotfiles
#   Version: 1.0
#
#   Usage: webinstaller.sh
#
#   Description:
#		Curl-able/wget-able webinstaller for my dotfiles
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

# Check if Git is installed.
[[ ! -x "$(command -v git)" ]] &&
    PRINT "Git is not installed." && exit 1

# Confirm uninstallation
read -r -p "Are you sure you want to uninstall this? (y/N) " confirm

PRINT ""

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
    PRINT "Cancelling."
    exit 1
}

# Uninstall scripts
PRINT "Uninstalling scripts..."
[[ -L "${SCRIPTS}" ]] && rm -f "${SCRIPTS}"

# Uninstall shell files
PRINT "Uninstalling shell configs..."
[[ -L "${ZSHRC}" ]] || rm -f "${ZSHRC}"
[[ -L "${BASHRC}" ]] || rm -f "${BASHRC}"
[[ -L "${SHELLFILES}" ]] || rm -f "${SHELLFILES}"

# Uninstall miscellany configs
PRINT "Uninstalling miscellaneous configs..."

for folder in "${DOTFILES}"/.config/*; do
    linkRef="${folder##*/}"
    sym="${HOME}/.config/${linkRef}"

    PRINT "Uninstalling config ${linkRef}..."

    [[ -L "${sym}" ]] && rm -f "${sym}"
done

# Delete dotfiles
PRINT "Deleting dotfiles..."
rm -rf "${DOTFILES_DIR}"

# Finish
PRINT "Done."
