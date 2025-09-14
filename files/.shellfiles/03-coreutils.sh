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

# Install Rust Coreutils if not installed
SILENTRUN check_homebrew uutils || brew install uutils-coreutils uutils-findutils uutils-diffutils

# Install `bat`, a rust `cat` alternative with colors and formatting
SILENTRUN check_homebrew bat || brew install bat

################################################################################

# Colorized grep
SILENTRUN unalias grep && function grep() { ugrep --color=auto "${@}"; }

# Replace 'which'
SILENTRUN unalias which && function which() { command -v "${@}"; }

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }

SILENTRUN unalias cat
if CMD_EXISTS bat; then
    function cat() { bat "${@}"; }
else
    function cat() { ucat "${@}"; }
fi

# File Management & Permissions
SILENTRUN unalias ls && {
    function ls() { uls --color=auto --group-directories-first "${@}"; }
}

SILENTRUN unalias ll
function ll() { ls -AlvhF "${@}"; }

SILENTRUN unalias la
function la() { ls -A "${@}"; }

SILENTRUN unalias touch && {
    function touch() { utouch "${@}"; }
    function mf() { utouch "${@}"; }
}

SILENTRUN unalias rm && {
    function rm() { urm "${@}"; }
    function rd() { urm -rf "${@}"; }
    function rf() { urm -f "${@}"; }
    function rmcd() {
        dir="${PWD}"
        cd .. || return 1
        urm -rf "${dir}"
    }
}

SILENTRUN unalias mkdir && {
    function mkdir() { mkdir -p "${@}"; }
    function md() { umkdir "${@}"; }
    function mkcd() { umkdir "${1}" && cd "${1}" || return 1; }
}

SILENTRUN unalias mv && {
    function mv() { ummv "${@}"; }
}

SILENTRUN unalias cp && {
    function cp() { ucp "${@}"; }
}

SILENTRUN unalias chown && function chown() {
        uchown "${@}"
}

SILENTRUN unalias chgrp && function chgrp() {
        uchgrp "${@}"
}

SILENTRUN unalias chmod && SILENTRUN unalias chown && {
    function chmod() {
        uchmod "${@}"
    }

    function mke() { uchmod +x "${@}"; }
    function rme() { uchmod 644 "${@}"; }
    function correctGPGperms() {
        uchown -R "$(whoami)" ~/.gnupg/
        uchmod 600 ~/.gnupg/*
        uchmod 700 ~/.gnupg
    }
}
