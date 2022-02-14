#!/usr/bin/env bash

################################################################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
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
export SYM_SCRIPTS="${DOTFILES}/Scripts"

# Paths
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/Scripts"

function PRINT() { printf '%b\n' "${@}"; }

################################# LOGIC ########################################

# Check if Git is installed.
[[ ! -x "$(command -v git)" ]] &&
	PRINT "Git is not installed." && {
	sleep 0.5
	exit 1
}

# Confirm installation
read -r -p "Are you sure you want to install this? (y/N) " confirm

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
	PRINT "Cancelling."

	sleep 0.5
	exit 1
}

# Check if dotfiles exist
[[ -d "${DOTFILES_DIR}" ]] && {
	PRINT "Dotfiles directory exists. Try using the update script."
	PRINT "Exiting..."

	sleep 0.5
	exit 1
}

# If user wishes to contribute, use SSH
sleep 0.5
read -r -p "Will you be contributing to these dotfiles? (y/N) " contrib
[[ "${contrib}" =~ ^[yY][eE]?[sS]?$ ]] && DOTFILES_SITE="${DOTFILES_SITE_SSH}"

# Download dotfiles
sleep 0.5
PRINT "Downloading dotfiles..."
cd "${DOTFILES_DOWN_DIR}" || exit 1
git clone "${DOTFILES_SITE}"

# Install scripts
sleep 0.5
PRINT "Installing scripts..."
ln -s "${SYM_SCRIPTS}" "${SCRIPTS}"

# Install shellfiles
sleep 0.5
PRINT "Installing shell configs..."
rm -f "${ZSHRC}" && ln -s "${SYM_ZSHRC}" "${ZSHRC}" && sleep 0.5
rm -f "${BASHRC}" && ln -s "${SYM_BASHRC}" "${BASHRC}" && sleep 0.5
ln -s "${SYM_SHELLFILES}" "${SHELLFILES}" && sleep 0.5

# Remove rogue symlinks
sleep 0.5
PRINT "Removing rogue symlinks..."
[[ -L "${SHELLFILES}/.shellfiles" ]] && rm -f "${SHELLFILES}/.shellfiles"

# Install miscellany configs
sleep 0.5
PRINT "Installing miscellaneous configs..."

for folder in "${DOTFILES}"/.config/*; do
	name="$(basename "${folder}")"
	sym="${HOME}/.config/${name}"

	sleep 0.5

	PRINT "Installing config '${name}'..."

	[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"

done

# Finish
PRINT "Dotfiles installed to '${DOTFILES_DIR}'."
