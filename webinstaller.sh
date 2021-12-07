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

DOTFILES_SITE="https://github.com/rmj1001/dotfiles.git"
DOTFILES_DOWN_DIR="${HOME}/.local/share/com.github.rmj1001.dotfiles"
DOTFILES="${DOTFILES_DOWN_DIR}/files"

# OG Paths
SYM_ZSHRC="${DOTFILES}/.zshrc"
SYM_BASHRC="${DOTFILES}/.bashrc"
SYM_SHELLFILES="${DOTFILES}/.shellfiles"
SYM_SCRIPTS="${DOTFILES}/System32"

# Paths
ZSHRC="${HOME}/.zshrc"
BASHRC="${HOME}/.bashrc"
SHELLFILES="${HOME}/.shellfiles"
SCRIPTS="${HOME}/System32"

################################# FUNCTIONS ######################################

confirmation() {
	local confirm
	local question="${1}"

	printf "%b" "${question}? (y/N) " && read -r confirm
	printf '%b\n' ""

	[[ "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && return 0

	return 1
}

install_scripts() {
	confirmation "Install scripts" || return 0

	printf "%b\n" "Installing scripts..."
	[[ -L "${SYM_SCRIPTS}" ]] || ln -sf "${SYM_SCRIPTS}" "${SCRIPTS}"
}

install_shellfiles() {
	confirmation "Install shell configs" || return 0

	printf "%b\n" "Installing shell configs..."
	[[ -L "${SYM_ZSHRC}" ]] || ln -sf "${SYM_ZSHRC}" "${ZSHRC}"
	[[ -L "${SYM_BASHRC}" ]] || ln -sf "${SYM_BASHRC}" "${BASHRC}"
	[[ -L "${SYM_SHELLFILES}" ]] || ln -sf "${SYM_SHELLFILES}" "${SHELLFILES}"
}

install_configs() {
	confirmation "Install miscellaneous configs" || return 0

	printf "%b\n" "Installing miscellaneous configs..."

	for folder in "${DOTFILES}"/.config/*; do
		linkRef="${folder##*/}"
		sym="${HOME}/.config/${linkRef}"

		printf "%b\n" "Installing config ${linkRef}..."

		[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"
	done
}

################################# LOGIC ########################################

# Check if Git is installed.
[[ ! -x "$(command -v git)" ]] &&
	printf '%b\n' "Git is not installed." && exit 1

confirm "Are you sure you want to install this" || exit 1

# Download dotfiles
printf "%b\n" "Downloading dotfiles..."
git pull "${DOTFILES_SITE}" "${DOTFILES_DOWN_DIR}"

install_scripts
install_shellfiles
install_configs

printf "%b\n" "Done."
