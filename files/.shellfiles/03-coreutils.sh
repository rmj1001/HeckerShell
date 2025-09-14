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

if ! SILENTRUN check_homebrew uutils; then
    brew install uutils-coreutils uutils-findutils uutils-diffutils
fi

# Cat alternative
if ! SILENTRUN check_homebrew bat; then
    brew install bat
fi

################################################################################

# Colorized grep
UNALIAS grep
function grep() { ugrep --color=auto "${@}"; }

# Replace 'which'
UNALIAS which && function which() { command -v "${@}"; }

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }

UNALIAS cat
if CMD_EXISTS bat; then
    function cat() { bat "${@}"; }
else
    function cat() { ucat "${@}"; }
fi

# File Management & Permissions
UNALIAS ls
function ls() { uls --color=auto --group-directories-first "${@}"; }

UNALIAS ll
function ll() { ls -AlvhF "${@}"; }

UNALIAS la
function la() { ls -A "${@}"; }

UNALIAS touch
function touch() { utouch "${@}"; }
function mf() { utouch "${@}"; }

UNALIAS rm
function rm() { urm "${@}"; }
function rd() { urm -rf "${@}"; }
function rf() { urm -f "${@}"; }
function rmcd() {
    dir="${PWD}"
    cd .. || return 1
    urm -rf "${dir}"
}

UNALIAS mkdir
function mkdir() { mkdir -p "${@}"; }
function md() { umkdir "${@}"; }
function mkcd() { umkdir "${1}" && cd "${1}" || return 1; }

UNALIAS mv
function mv() { ummv "${@}"; }

UNALIAS cp
function cp() { ucp "${@}"; }

UNALIAS chown
function chown() {
        uchown "${@}"
}

UNALIAS chgrp
function chgrp() {
        uchgrp "${@}"
}

UNALIAS chmod
UNALIAS chown 
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
