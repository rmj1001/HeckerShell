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

if [[ -d "${HECKERSHELL}" ]]; then
    source "${HECKERSHELL}/auto/variables.sh"
    source "${HECKERSHELL}/files/.shellfiles/00-api.sh"
else
    GITHUB_URL="https://raw.githubusercontent.com/rmj1001/HeckerShell/refs/heads/main"
    source <(wget -qO- $GITHUB_URL/auto/variables.sh)
    source <(wget -qO- $GITHUB_URL/files/.shellfiles/00-api.sh)
fi

################################# LOGIC ########################################

if ! CMD_EXISTS git; then
    PRINT "Git is not installed."
    sleep 0.5
    exit 1
fi

cd "${HECKERSHELL}" || { PRINT 'HeckerShell does not exist.' && exit 1; }

# Confirm update
if ASK "Changes you made will be lost. Continue update?"; then
    git pull
    exit 0
else
    PRINT "Cancelling."
    exit 1
fi
