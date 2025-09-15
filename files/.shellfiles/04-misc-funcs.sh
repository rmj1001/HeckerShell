#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

############################ SHELL FUNCTIONS ###################################

### youtube-dl alias for yt-dlp
# Usage: youtube-dl <args?[]>
CMD_EXISTS "yt-dlp" && function youtube-dl() {
    yt-dlp "${@}"
}

# If neofetch doesn't exist, use `aboutpc` script
function fetch() {
    CMD_EXISTS "neofetch" && neofetch "${@}" && return 0
    aboutpc --neofetch "${@}"
}

# Edit files
function edit() { "${EDITOR}" "${@}"; }
function rootedit() { "${AUTH}" "${EDITOR}" "${@}"; }

# Copy text from STDIN or from a file
function copy() { xclip -sel clip "${@}"; }

# Cat a file w/ line numbers
function readfile() { ucat -n "${@}"; }

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

############################ PLATFORM FUNCTIONS ###################################

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
