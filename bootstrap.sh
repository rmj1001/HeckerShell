#!/usr/bin/env bash

DOTFILES="$(dirname "$(readlink -f "${0}")")/files"

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

PRINT() {
	printf "%b\n" "$1"
}

LOWERCASE() {
	local text="$1"
	printf "%b\n" "${text}" | tr '[:upper:]' '[:lower:]'
}

_install() {
	local linkRef
	local sym

	PRINT

	# Scripts
	PRINT "Installing scripts..."
	[[ -L "${SYM_SCRIPTS}" ]] || ln -s "${SYM_SCRIPTS}" "${SCRIPTS}"

	# ZSH
	PRINT "Installing shell configs..."
	[[ -L "${SYM_ZSHRC}" ]] || ln -s "${SYM_ZSHRC}" "${ZSHRC}"
	[[ -L "${SYM_BASHRC}" ]] || ln -s "${SYM_BASHRC}" "${BASHRC}"
	[[ -L "${SYM_SHELLFILES}" ]] || ln -s "${SYM_SHELLFILES}" "${SHELLFILES}"

	# Configs
	PRINT "Installing miscellaneous configs..."

	for folder in "${DOTFILES}"/.config/*; do
		linkRef="${folder##*/}"
		sym="${HOME}/.config/${linkRef}"

		PRINT "Installing config ${linkRef}..."

		[[ -L "${sym}" ]] || ln -s "${folder}" "${sym}"
	done

	PRINT "Done."
}

_remove() {
	PRINT

	# Scripts
	PRINT "Removing scripts symlink..."
	[[ -L "${SYM_SCRIPTS}" ]] && rm "${SYM_SCRIPTS}"

	# ZSH
	PRINT "Removing shell config symlinks..."
	[[ -L "${SYM_ZSHRC}" ]] && rm "${SYM_ZSHRC}" "${ZSHRC}"
	[[ -L "${SYM_BASHRC}" ]] && rm "${SYM_BASHRC}" "${BASHRC}"
	[[ -L "${SYM_SHELLFILES}" ]] && rm "${SYM_SHELLFILES}" "${SHELLFILES}"

	# Configs
	PRINT "Removing miscellaneous configs..."

	local linkRef
	local sym

	for folder in "${DOTFILES}"/.config/*; do
		linkRef="${folder##*/}"
		sym="$HOME/.config/${linkRef}"

		PRINT "Removing config ${linkRef}..."

		[[ -L "${sym}" ]] && rm "${sym}"
	done

	PRINT "Done."
}

_update() {
	cd "$DOTFILES"/.. || return 1

	git pull
}

_help() {
	_help.commands() {
		PRINT "Command|Arguments|Description"
		PRINT "(i) install||Install dotfiles to the system"
		PRINT "(r) remove||Remove dotfiles from the system"
		PRINT "(u) update||Update the dotfiles repo"
		PRINT "(h) help||Show this help menu"
	}

	PRINT
	PRINT "Install/Uninstall symlinks to important dotfiles"
	PRINT
	PRINT "Usage:\t\tbootstrap.sh <command>"
	PRINT "Example:\tbootstrap.sh install"
	PRINT
	_help.commands | column -t -s "|"
}

case "$(LOWERCASE "${1}")" in

i | install) _install ;;
r | remove) _remove ;;
u | update) _update ;;
\? | h | help) _help ;;
*) [[ -z "${1}" ]] && _help && exit 0 || PRINT "Invalid subcommand '${1}'." &&
	exit 1 ;;

esac
