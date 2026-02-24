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

if ! ASK "Do you want to install HeckerShell?"; then
    PRINT "Cancelling."
    sleep 0.5
    exit 1
fi

# Check if HeckerShell exist
if test -d "${HECKERSHELL}"; then
	PRINT "HeckerShell directory exists. Try using the update script."
	PRINT "Exiting..."

	sleep 0.5
	exit 1
fi

# If user wishes to contribute, use SSH
sleep 0.5

if ASK "Contribute to HeckerShell?"; then
    HECKERSHELL_SITE="${HECKERSHELL_SITE_SSH}"
fi

# Download HeckerShell
sleep 0.5
PRINT "Downloading HeckerShell..."
cd "${HECKERSHELL_PARENT}" || exit 1
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

for folder in "${HECKERSHELL_FS}"/.config/*; do
	name="$(basename "${folder}")"
	sym="${HOME}/.config/${name}"

	sleep 0.5

	PRINT "Installing config '${name}'..."

	[[ -L "${sym}" ]] || SYM "${folder}" "${sym}"

done

# Ask if they wish to print the MOTD
if ASK "Use default MOTD?"; then
    PRINT "Disabling default motd."
	touch "${HECKERSHELL_FS}/.noMOTD"
fi

# Ask to install homebrew
if test ! -d /home/linuxbrew && ASK "Install homebrew?"; then
    PRINT "Installing homebrew..."
   	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Finish
PRINT "HeckerShell installed to '${HECKERSHELL}'."

PRINT "Tips:"
PRINT "- Use 'shell motd ?' to enable/disable/customize your MOTD."
PRINT "- Use 'shell fresh-screen' to clear the screen and print the MOTD."
PRINT "- Use 'shell reload' to reload the shell configuration."
