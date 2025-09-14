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

############################ SHELL FUNCTIONS ###################################

### youtube-dl alias for yt-dlp
# Usage: youtube-dl <args?[]>
CMD_EXISTS "yt-dlp" && function youtube-dl() {
    yt-dlp "${@}"
}

# If neofetch doesn't exist, use `aboutpc` script
function neofetch() {
    CMD_EXISTS "neofetch" && neofetch "${@}" && return 0
    aboutpc --neofetch "${@}"
}

# Edit files
function edit() { "${EDITOR}" "${@}"; }
function rootedit() { "${AUTH}" "${EDITOR}" "${@}"; }

# Copy text from STDIN or from a file
function copy() { xclip -sel clip "${@}"; }

# Colorized grep
SILENTRUN unalias grep && function grep() { ugrep --color=auto "${@}"; }

# Cat a file w/ line numbers
function readfile() { ucat -n "${@}"; }

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

# Man pages
function manual() {
    man "${@}"
}

# Update software from source
CMD_EXISTS make && CMD_EXISTS git && function makeupdate() {
    sudo make uninstall &&
        make clean &&
        git pull &&
        make &&
        sudo make install
}

# Install gaming software
CMD_EXISTS pipe3 && function install-gaming() {
    pipe3 install LibreGaming && LibreGaming --tui
}

# Update gaming software
CMD_EXISTS pipe3 && function update-gaming() {
    pipe3 install LibreGaming -U && LibreGaming --tui
}

# Home
function home() { cd "${HOME}" || return 1; }

# Linux-specific functions
if [[ "$(uname -s)" == "Linux" ]]; then
    # Audio
    function restart-bluetooth() {
        systemctl restart --user bluetooth
    }

    function restart-pipewire() {
        systemctl restart --user pipewire
        systemctl restart --user pipewire-pulse
        restart-bluetooth
    }

    # List of attached hardware
    function ls-hardware() {
        lshw "${@}"
    }

    # Get list of flatpaks
    function ls-flatpaks() {
        flatpak list --columns=application "${@}" | tail -n +1
    }
fi

# Default apps
function terminal() { ${TERMINAL} "${@}"; }
function browser() { ${BROWSER} "${@}"; }
function auth() { ${AUTH} "${@}"; }

# Clear screen
function cls() { shell fresh-screen; }

# Meme Functions
function @echo { [[ "$1" == "off" ]] && PRINT "This isn't batch nerd"; }
function man-meme() {
    printf "%b\n" "Based sigma grindset gender, not woman"
}

# Java
function runjar() { java -jar "${@}"; }
function silentrunjar() { ASYNC java -jar "${@}"; }

# Run text file as bash
function runInBash() {
    bash <(cat "$1")
}
