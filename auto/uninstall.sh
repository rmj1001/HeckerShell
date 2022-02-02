#!/usr/bin/env bash

################################################################################
#   Author: Roy Conn
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

################################# LOGIC ########################################

# Check if Git is installed.
[[ ! -x "$(command -v git)" ]] &&
    printf '%b\n' "Git is not installed." && exit 1

# Confirm uninstallation
read -r -p "Are you sure you want to uninstall this? (y/N) " confirm

printf '%b\n' ""

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
    printf '%b\n' "Cancelling."
    exit 1
}

# Uninstall scripts
printf "%b\n" "Uninstalling scripts..."
[[ -L "${SCRIPTS}" ]] && rm -f "${SCRIPTS}"

# Uninstall shell files
printf "%b\n" "Uninstalling shell configs..."
[[ -L "${ZSHRC}" ]] || rm -f "${ZSHRC}"
[[ -L "${BASHRC}" ]] || rm -f "${BASHRC}"
[[ -L "${SHELLFILES}" ]] || rm -f "${SHELLFILES}"

# Uninstall miscellany configs
printf "%b\n" "Uninstalling miscellaneous configs..."

for folder in "${DOTFILES}"/.config/*; do
    linkRef="${folder##*/}"
    sym="${HOME}/.config/${linkRef}"

    printf "%b\n" "Uninstalling config ${linkRef}..."

    [[ -L "${sym}" ]] && rm -f "${sym}"
done

# Delete dotfiles
printf "%b\n" "Deleting dotfiles..."
rm -rf "${DOTFILES_DIR}"

# Finish
printf "%b\n" "Done."
