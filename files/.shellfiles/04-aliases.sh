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
