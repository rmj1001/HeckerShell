#!/usr/bin/env bash

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

PRINT()
{
	printf "%b\n" "$1"
}

LOWERCASE()
{
	local text="$1"
	printf "%b\n" "${text}" | tr '[:upper:]' '[:lower:]'
}

_download()
{
	PRINT "Downloading dotfiles..."
	git pull ${DOTFILES_SITE} ${DOTFILES_DOWN_DIR}
}

_install()
{
	local linkRef;
	local sym;

	PRINT

	# Scripts
	PRINT "Installing scripts..."
	[[ -h "${SYM_SCRIPTS}" ]] || ln -sf ${SYM_SCRIPTS} ${SCRIPTS}

	# ZSH
	PRINT "Installing shell configs..."
	[[ -h "${SYM_ZSHRC}" ]] || ln -sf ${SYM_ZSHRC} ${ZSHRC}
	[[ -h "${SYM_BASHRC}" ]] || ln -sf ${SYM_BASHRC} ${BASHRC}
	[[ -h "${SYM_SHELLFILES}" ]] || ln -sf ${SYM_SHELLFILES} ${SHELLFILES}

	# Configs
	PRINT "Installing miscellaneous configs..."

	for folder in ${DOTFILES}/.config/*
	do
		linkRef="${folder##*/}"
		sym="${HOME}/.config/${linkRef}"

		PRINT "Installing config ${linkRef}..."

		[[ -h "${sym}" ]] || ln -s ${folder} ${sym}
	done

	PRINT "Done."
}

_download

PRINT "Install? (Y/n) " && read confirm

[[ ! "${confirm}" =~ ^[nN][oO]?$ ]] && _install && exit $? || PRINT "Downloaded but not installed." && read && clear && exit 0

