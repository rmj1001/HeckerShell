#!/usr/bin/env bash

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

installScripts() {
	printf "%b\n" "Installing scripts..."
	[[ -L "${SYM_SCRIPTS}" ]] || ln -sf "${SYM_SCRIPTS}" "${SCRIPTS}"
}

installShell() {
	printf "%b\n" "Installing shell configs..."
	[[ -L "${SYM_ZSHRC}" ]] || ln -sf "${SYM_ZSHRC}" "${ZSHRC}"
	[[ -L "${SYM_BASHRC}" ]] || ln -sf "${SYM_BASHRC}" "${BASHRC}"
	[[ -L "${SYM_SHELLFILES}" ]] || ln -sf "${SYM_SHELLFILES}" "${SHELLFILES}"
}

installConfigs() {
	# Configs
	printf "%b\n" "Installing miscellaneous configs..."

	for folder in "${DOTFILES}"/.config/*; do
		linkRef="${folder##*/}"
		sym="${HOME}/.config/${linkRef}"

		printf "%b\n" "Installing config ${linkRef}..."

		[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"
	done
}

[[ ! -x "$(command -v git)" ]] &&
	printf '%b\n' "Git is not installed." && exit 1

# Confirm whether to install dotfiles.
printf '%b' "Are you sure you want to install this script?
This script will delete certain files, including your current bashrc.\n
Confirm? (y/N) " && read -r confirmInstall && printf "%b\n" ""

[[ ! "${confirmInstall}" =~ ^[yY][eE]?[sS]?$ ]] &&
	printf "%b\n" "Cancelling." && exit 1

# Download dotfiles
printf "%b\n" "Downloading dotfiles..."
git pull "${DOTFILES_SITE}" "${DOTFILES_DOWN_DIR}"

# Scripts
printf "%b" "Install scripts? (y/N) " && read -r confirmScripts
printf '%b\n' ""
[[ "${confirmScripts}" =~ ^[yY][eE]?[sS]?$ ]] && installScripts

# Shell configs
printf "%b" "Install shell configs? (y/N) " && read -r confirmShell
printf '%b\n' ""
[[ "${confirmShell}" =~ ^[yY][eE]?[sS]?$ ]] && installShell

# Misc configs
printf "%b\n" "Install miscellaneous configs? (y/N) " && read -r confirmConfs
printf '%b\n' ""
[[ "${confirmConfs}" =~ ^[yY][eE]?[sS]?$ ]] && installConfigs

printf "%b\n" "Done."
