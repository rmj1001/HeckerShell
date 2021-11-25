#!/usr/bin/env bash

################################# FUNCTIONS ####################################

PRINT() {
	printf "%b\n" "$1"
}

LOWERCASE() {
	local text="$1"
	printf "%b\n" "${text}" | tr '[:upper:]' '[:lower:]'
}

################################# CONSTANTS ####################################

DOTFILES_SITE="https://github.com/rmj1001/dotfiles"
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

################################# LOGIC ########################################

PRINT "Downloading dotfiles..."
git pull "${DOTFILES_SITE}" "${DOTFILES_DOWN_DIR}"

printf "%b" "$1" "Install? (Y/n) " && read -r confirm

[[ "${confirm}" =~ ^[nN][oO]?$ ]] && printf '%b' \
	"Downloaded but not installed.\n\nPress ENTER to continue..." && read -r &&
	clear && exit 0

PRINT

# Scripts
PRINT "Installing scripts..."
[[ -L "${SYM_SCRIPTS}" ]] || ln -sf "${SYM_SCRIPTS}" "${SCRIPTS}"

# ZSH
PRINT "Installing shell configs..."
[[ -L "${SYM_ZSHRC}" ]] || ln -sf "${SYM_ZSHRC}" "${ZSHRC}"
[[ -L "${SYM_BASHRC}" ]] || ln -sf "${SYM_BASHRC}" "${BASHRC}"
[[ -L "${SYM_SHELLFILES}" ]] || ln -sf "${SYM_SHELLFILES}" "${SHELLFILES}"

# Configs
PRINT "Installing miscellaneous configs..."

for folder in "${DOTFILES}"/.config/*; do
	linkRef="${folder##*/}"
	sym="${HOME}/.config/${linkRef}"

	PRINT "Installing config ${linkRef}..."

	[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"
done

PRINT "Done."
