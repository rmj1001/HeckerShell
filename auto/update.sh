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
else
    source <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/refs/heads/main/auto/variables.sh)
fi

################################# LOGIC ########################################

# Checks to see an input matches case-insensitive 'yes'
ask() {
    read -r -p "${@} (y/N) " confirm

    if echo "${confirm}" | grep -iE '^(y|yes)$' -; then
        return 0
    else
        return 1
    fi
}

[[ -x "$(command -v git)" ]] || { PRINT "" \
    'git must be installed.' && exit 1; }

cd "${HECKERSHELL_DIR}" || { PRINT 'HeckerShell does not exist.' && exit 1; }

# Confirm update
ask "Changes you made will be lost. Continue update?" && git pull && exit 0

PRINT "Cancelling."; exit 1
