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

# Get variables and functions
GITHUB_URL="https://raw.githubusercontent.com/rmj1001/HeckerShell/refs/heads/main"
source <(wget -qO- $GITHUB_URL/auto/variables.sh)
source <(wget -qO- $GITHUB_URL/files/.shellfiles/00-api.sh)

################################# LOGIC ########################################

# Check if Git is installed.
if ! CMD_EXISTS git; then
	PRINT "Git is not installed."
	sleep 0.5
	exit 1
fi

# Confirm uninstallation
if ! ASK "Do you want to uninstall HeckerShell?"; then
    PRINT "Cancelling."
    sleep 0.5
    exit 1
fi

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

for folder in "${HECKERSHELL_FS}"/.config/*; do
    linkRef="${folder##*/}"
    sym="${HOME}/.config/${linkRef}"

    PRINT "Uninstalling config ${linkRef}..."

    [[ -L "${sym}" ]] && rm -f "${sym}"
done

# Delete HeckerShell
PRINT "Deleting HeckerShell..."
rm -rf "${HECKERSHELL}"

# Finish
PRINT "Done."
