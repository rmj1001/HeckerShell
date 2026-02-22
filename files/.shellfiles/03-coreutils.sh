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

# File Management & Permissions
if CMD_EXISTS uu-ls; then
    UNALIAS ls
    function ls() { uu-ls --color=auto --group-directories-first "${@}"; }
fi

UNALIAS ll
function ll() { ls -AlvhF "${@}"; }

UNALIAS la
function la() { ls -A "${@}"; }

if CMD_EXISTS utouch; then
    UNALIAS touch
    function touch() { uu-touch "${@}"; }
    function mf() { uu-touch "${@}"; }
fi

if CMD_EXISTS uu-rm; then
    UNALIAS rm
    function rm() { uu-rm "${@}"; }
    function rd() { uu-rm -rf "${@}"; }
    function rf() { uu-rm -f "${@}"; }
    function rmcd() {
        dir="${PWD}"
        cd .. || return 1
        uu-rm -rf "${dir}"
    }
fi

if CMD_EXISTS uu-mkdir; then
    UNALIAS mkdir
    function md() { uu-mkdir "${@}"; }
    function mkcd() { uu-mkdir "${1}" && cd "${1}" || return 1; }
fi

if CMD_EXISTS uu-mv; then
    UNALIAS mv
    function mv() { uu-mv "${@}"; }
fi

if CMD_EXISTS uu-cp; then
    UNALIAS cp
    function cp() { uu-cp "${@}"; }
fi

if CMD_EXISTS uu-chown; then
    UNALIAS chown
    function chown() {
            uu-chown "${@}"
    }
fi

if CMD_EXISTS uu-chgrp; then
    UNALIAS chgrp
    function chgrp() {
            uu-chgrp "${@}"
    }
fi

if CMD_EXISTS uu-chmod; then
    UNALIAS chmod
    function chmod() {
        uu-chmod "${@}"
    }
fi

function mke() { uu-chmod +x "${@}"; }
function rme() { uu-chmod 644 "${@}"; }
function correctGPGperms() {
    uu-chown -R "$(whoami)" ~/.gnupg/
    uu-chmod 600 ~/.gnupg/*
    uu-chmod 700 ~/.gnupg
}
