#!/usr/bin/env bash

################################################################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: webinstaller.sh
#
#   Description:
#		Curl-able/wget-able webinstaller for HeckerShell
################################################################################

################################# CONSTANTS ####################################

# HeckerShell urls
export HECKERSHELL_SITE_HTTPS="https://github.com/rmj1001/HeckerShell.git"
export HECKERSHELL_SITE_SSH="git@github.com:rmj1001/HeckerShell.git"
export HECKERSHELL_SITE="${HECKERSHELL_SITE_HTTPS}"

# HeckerShell directories
export HECKERSHELL_DOWN_DIR="${HOME}/.local/share"
export HECKERSHELL_DIR="${HECKERSHELL_DOWN_DIR}/HeckerShell"
export HECKERSHELL="${HECKERSHELL_DIR}/files"

# OG Paths
export SYM_ZSHRC="${HECKERSHELL}/.zshrc"
export SYM_BASHRC="${HECKERSHELL}/.bashrc"
export SYM_SHELLFILES="${HECKERSHELL}/.shellfiles"
export SYM_SCRIPTS="${HECKERSHELL}/Scripts"

# Paths
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/Scripts"

function PRINT() { printf '%b\n' "${@}"; }
function SYM() { ln -s "${@}"; }

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

# Check if HeckerShell exist
[[ -d "${HECKERSHELL_DIR}" ]] && {
	PRINT "HeckerShell directory exists. Try using the update script."
	PRINT "Exiting..."

	sleep 0.5
	exit 1
}

# If user wishes to contribute, use SSH
sleep 0.5
read -r -p "Will you be contributing to HeckerShell? (y/N) " contrib
[[ "${contrib}" =~ ^[yY][eE]?[sS]?$ ]] && HECKERSHELL_SITE="${HECKERSHELL_SITE_SSH}"

# Download HeckerShell
sleep 0.5
PRINT "Downloading HeckerShell..."
cd "${HECKERSHELL_DOWN_DIR}" || exit 1
git clone "${HECKERSHELL_SITE}"

# Install scripts
sleep 0.5
PRINT "Installing scripts..."
SYM "${SYM_SCRIPTS}" "${SCRIPTS}"

# Install shellfiles
sleep 0.5
PRINT "Installing shell configs..."
rm -f "${ZSHRC}" && SYM "${SYM_ZSHRC}" "${ZSHRC}" && sleep 0.5
rm -f "${BASHRC}" && SYM "${SYM_BASHRC}" "${BASHRC}" && sleep 0.5
SYM "${SYM_SHELLFILES}" "${SHELLFILES}" && sleep 0.5

# Remove rogue symlinks
sleep 0.5
PRINT "Removing rogue symlinks..."
[[ -L "${SHELLFILES}/.shellfiles" ]] && rm -f "${SHELLFILES}/.shellfiles"

# Install miscellany configs
sleep 0.5
PRINT "Installing miscellaneous configs..."

for folder in "${HECKERSHELL}"/.config/*; do
	name="$(basename "${folder}")"
	sym="${HOME}/.config/${name}"

	sleep 0.5

	PRINT "Installing config '${name}'..."

	[[ -L "${sym}" ]] || SYM "${folder}" "${sym}"

done

# Ask if they wish to print the MOTD
read -r -p "Use default MOTD? (y/N) " confirm

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
	PRINT "Disabling default motd."
	touch "${HECKERSHELL}/.noMOTD"
}

# Finish
PRINT "HeckerShell installed to '${HECKERSHELL_DIR}'."
