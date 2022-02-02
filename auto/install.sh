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

################################# LOGIC ########################################

# Check if Git is installed.
[[ ! -x "$(command -v git)" ]] &&
	printf '%b\n' "Git is not installed." && exit 1

# Confirm installation
read -r -p "Are you sure you want to install this? (y/N) " confirm

printf '%b\n' ""

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
	printf '%b\n' "Cancelling."
	exit 1
}

# Source environment variables
wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto/env.sh |
	source /dev/stdin

# Check if dotfiles exist
[[ -d "${DOTFILES_DOWN_DIR}/dotfiles" ]] && {
	printf "%b\n" "Dotfiles directory exists. Try using the update script."
	printf "%b\n" "Exiting..."
	exit 1
}

# If user wishes to contribute, use SSH
read -r -p "Will you be contributing to these dotfiles? (y/N) " contrib
[[ "${contrib}" =~ ^[yY][eE]?[sS]?$ ]] && DOTFILES_SITE="${DOTFILES_SITE_SSH}"

# Download dotfiles
printf "%b\n" "Downloading dotfiles..."
cd "${DOTFILES_DOWN_DIR}" || exit 1
git clone "${DOTFILES_SITE}"

# Install scripts
printf "%b\n" "Installing scripts..."
ln -sf "${SYM_SCRIPTS}" "${SCRIPTS}"

# Install shellfiles
printf "%b\n" "Installing shell configs..."
ln -sf "${SYM_ZSHRC}" "${ZSHRC}"
ln -sf "${SYM_BASHRC}" "${BASHRC}"
ln -sf "${SYM_SHELLFILES}" "${SHELLFILES}"

# Install miscellany configs
printf "%b\n" "Installing miscellaneous configs..."

for folder in "${DOTFILES}"/.config/*; do
	linkRef="${folder##*/}"
	sym="${HOME}/.config/${linkRef}"

	printf "%b\n" "Installing config ${linkRef}..."

	[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"
done

# Finish
printf "%b\n" "Dotfiles installed to '${DOTFILES_DOWN_DIR}/dotfiles'."
