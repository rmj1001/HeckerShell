#!/bin/bash

################################################################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: update.sh
#
#   Description:
#		Curl-able/wget-able updater for HeckerShell
################################################################################

################################# CONSTANTS ####################################

source <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/refs/heads/main/auto/variables.sh)

################################# LOGIC ########################################

[[ -x "$(command -v git)" ]] || { PRINT "" \
    'git must be installed.' && exit 1; }

cd "${HECKERSHELL_DIR}" || { PRINT 'HeckerShell does not exist.' && exit 1; }

# Confirm uninstallation
read -r -p \
    "Are you sure you want to update? Changes you made will be lost. (y/N) " \
    confirm

PRINT ""

[[ ! "${confirm}" =~ ^[yY][eE]?[sS]?$ ]] && {
    PRINT "Cancelling."
    exit 1
}

git pull
