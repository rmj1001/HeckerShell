#!/usr/bin/env bash

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
