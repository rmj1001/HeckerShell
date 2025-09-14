#!/bin/bash

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

source <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/refs/heads/main/auto/variables.sh)

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

for folder in "${HECKERSHELL}"/.config/*; do
    linkRef="${folder##*/}"
    sym="${HOME}/.config/${linkRef}"

    PRINT "Uninstalling config ${linkRef}..."

    [[ -L "${sym}" ]] && rm -f "${sym}"
done

# Delete HeckerShell
PRINT "Deleting HeckerShell..."
rm -rf "${HECKERSHELL_DIR}"

# Finish
PRINT "Done."
