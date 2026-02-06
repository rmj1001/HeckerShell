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

function REPLACE() {
    if CMD_EXISTS $1; then
        UNALIAS $1
        eval "function ${1}() { ${@:2} \"${@}\"; }"
    fi
}

# Colorized grep
if CMD_EXISTS ugrep; then
    UNALIAS grep
    function grep() { ugrep --color=auto "${@}"; }
fi

# Replace 'which'
# UNALIAS which && function which() { command -v "${@}"; }
REPLACE which 'command -v'

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }


if CMD_EXISTS bat; then
    UNALIAS cat
    function cat() { bat "${@}"; }
elif CMD_EXISTS ucat; then
    UNALIAS cat
    function cat() { ucat "${@}"; }
fi

# File Management & Permissions
if CMD_EXISTS uls; then
    UNALIAS ls
    function ls() { uls --color=auto --group-directories-first "${@}"; }
fi

UNALIAS ll
function ll() { ls -AlvhF "${@}"; }

UNALIAS la
function la() { ls -A "${@}"; }

if CMD_EXISTS utouch; then
    UNALIAS touch
    function touch() { utouch "${@}"; }
    function mf() { utouch "${@}"; }
fi

if CMD_EXISTS urm; then
    UNALIAS rm
    function rm() { urm "${@}"; }
    function rd() { urm -rf "${@}"; }
    function rf() { urm -f "${@}"; }
    function rmcd() {
        dir="${PWD}"
        cd .. || return 1
        urm -rf "${dir}"
    }
fi

if CMD_EXISTS umkdir; then
    UNALIAS mkdir
    function md() { umkdir "${@}"; }
    function mkcd() { umkdir "${1}" && cd "${1}" || return 1; }
fi

if CMD_EXISTS ummv; then
    UNALIAS mv
    function mv() { ummv "${@}"; }
fi

if CMD_EXISTS ucp; then
    UNALIAS cp
    function cp() { ucp "${@}"; }
fi

if CMD_EXISTS uchown; then
    UNALIAS chown
    function chown() {
            uchown "${@}"
    }
fi

if CMD_EXISTS uchgrp; then
    UNALIAS chgrp
    function chgrp() {
            uchgrp "${@}"
    }
fi

if CMD_EXISTS uchmod; then
    UNALIAS chmod
    function chmod() {
        uchmod "${@}"
    }
fi

function mke() { chmod +x "${@}"; }
function rme() { chmod 644 "${@}"; }
function correctGPGperms() {
    chown -R "$(whoami)" ~/.gnupg/
    chmod 600 ~/.gnupg/*
    chmod 700 ~/.gnupg
}
