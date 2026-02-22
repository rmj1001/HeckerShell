#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

############################ DEPENDENCIES ######################################

function check_homebrew() {
    brew list | grep "${@}"
}

function DEPENDENCY() {
    if ! SILENTRUN check_homebrew ${1}; then
        brew install ${1}
    fi
}

# Rust Coreutils
DEPENDENCY uutils-coreutils
DEPENDENCY uutils-findutils
DEPENDENCY uutils-diffutils
DEPENDENCY ugrep

# Cat alternative
DEPENDENCY bat

################################################################################

# Colorized grep
if CMD_EXISTS ugrep; then
    UNALIAS grep
    function grep() { ugrep --color=auto "${@}"; }
fi

# Replace 'which'
UNALIAS which && function which() { command -v "${@}"; }
#REPLACE which 'command -v'

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }


if CMD_EXISTS bat; then
    UNALIAS cat
    function cat() { bat "${@}"; }
elif CMD_EXISTS ucat; then
    UNALIAS cat
    function cat() { ucat "${@}"; }
fi


# Override builtin commands with uutils for interactive shell
PATH="$HOMEBREW_PREFIX/opt/uutils-coreutils/libexec/uubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/uutils-diffutils/libexec/uubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/uutils-findutils/libexec/uubin:$PATH"

# File listing
UNALIAS ll
function ll() { ls -AlvhF "${@}"; }

UNALIAS la
function la() { ls -A "${@}"; }

# File Management
function mf() { touch "${@}"; }

# Directory Management
function rd() { rm -rf "${@}"; }
function rf() { rm -f "${@}"; }
function rmcd() {
    dir="${PWD}"
    cd .. || return 1;
    rd "${dir}"
}

function md() { mkdir "${@}"; }
function mkcd() { mkdir "${1}" && cd "${1}" || return 1; }

# Permissions Editing
function mke() { chmod +x "${@}"; }
function rme() { chmod 644 "${@}"; }
function correctGPGperms() {
    chown -R "$(whoami)" ~/.gnupg/
    chmod 600 ~/.gnupg/*
    chmod 700 ~/.gnupg
}
