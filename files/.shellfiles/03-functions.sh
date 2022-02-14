#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Dotfiles functions
#
##############################################

############################ SHELL FUNCTIONS ###################################

### youtube-dl alias for yt-dlp
# Usage: youtube-dl <args?[]>
CMD_EXISTS "yt-dlp" && function youtube-dl() {
    yt-dlp "${@}"
}

### Download youtube videos (yt-dlp & youtube-dl)
# Usage: downloadYTVideo <video url>[]
function downloadYTVideo() {

    PRINT "This function does not currently work for yt-dlp."
    return 1

    # Preparations
    DIR=$HOME/Downloads/VideoDownloader
    [[ -d "$DIR" ]] ||
        mkdir "$DIR"
    cd "$DIR" || return 1

    CMD_EXISTS "yt-dlp" && {
        # yt-dlp "${@}"
        PRINT "This function does not currently work for yt-dlp."
        return 0
    }

    youtube-dl --format mp4 -o "%(title)s.%(ext)s" "${@}"
}

### Download youtube videos as MP3 sound files (yt-dlp & youtube-dl)
# Usage: mp3dl <video url>[]
function mp3dl() {

    PRINT "This function does not currently work for yt-dlp."
    return 1

    # Preparations
    DIR=$HOME/Downloads/Music
    [[ -d "$DIR" ]] || mkdir "$DIR"
    cd "$DIR" || return 1

    CMD_EXISTS "yt-dlp" && {
        # yt-dlp "${@}"
        PRINT "This function does not currently work for yt-dlp."
        return 0
    }

    # Download
    youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
        --extract-audio --audio-format mp3 "${@}"
}

### Add sound clips to soundfx folder (yt-dlp & youtube-dl)
# Usage: soundfx <video url>[]
function soundfx() {

    PRINT "This function does not currently work for yt-dlp."
    return 1

    # Preparations
    DIR=$HOME/Music/SoundFX
    [[ -d "$DIR" ]] || mkdir "$DIR"
    cd "$DIR" || return 1

    CMD_EXISTS "yt-dlp" && {
        # yt-dlp "${@}"
        PRINT "This function does not currently work for yt-dlp."
        return 0
    }

    # Download
    youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
        --extract-audio --audio-format mp3 "${@}"
}

# Edit files
function edit() { "${EDITOR}" "${@}"; }
function rootedit() { ${AUTH} "${EDITOR}" "${@}"; }

# Copy text from STDIN or from a file
function copy() { xclip -sel clip "${@}"; }

# Colorized grep
SILENTRUN unalias grep
function grep() { $(WHICH grep) --color=auto "${@}"; }

# Cat a file w/ line numbers
function readfile() { /bin/cat -n "${@}"; }

# Replace 'which'
function which() { WHICH "${@}"; }

# If bat/batcat exists, create opposite alias to replace cat
[[ -x /bin/bat ]] && function bat() { /bin/bat -P "${@}"; }
[[ -x /bin/batcat ]] && function bat() { /bin/batcat -P "${@}"; }

# Listing files/directories
SILENTRUN unalias ls
SILENTRUN unalias ll
SILENTRUN unalias la
function ls() {
    /usr/bin/env ls --color=auto --group-directories-first "${@}"
}
function ll() { ls -AlvhF "${@}"; }
function la() { ls -A "${@}"; }

# Directory manipulation
function mkdir() { /usr/bin/env mkdir -p "${@}"; }
function md() { mkdir "${@}"; }
function mf() { touch "${@}"; }
function rd() { rm -rf "${@}"; }
function rf() { rm -f "${@}"; }
function rmcd() {
    dir="${PWD}"
    cd .. || return 1
    rm -rf "${dir}"
}
function mkcd() { mkdir "${1}" && cd "${1}" || return 1; }

# File Permissions (Exec/Non-exec)
function mke() { chmod +x "${@}"; }
function rme() { chmod 644 "${@}"; }
function correctGPGperms() {
    chown -R "$(whoami)" ~/.gnupg/
    chmod 600 ~/.gnupg/*
    chmod 700 ~/.gnupg
}

# Man pages
function manual() {
    /usr/bin/man "${@}"
}

# Man meme
function man-meme() {
    printf "%b\n" "Based sigma grindset gender, not woman"
}

# Update software from source
function makeupdate() {
    sudo make uninstall &&
        make clean &&
        git pull &&
        make &&
        sudo make install
}

# Install gaming software
function install-gaming() {
    pipe3 install LibreGaming && LibreGaming --tui
}

# Update gaming software
function update-gaming() {
    pipe3 install LibreGaming -U && LibreGaming --tui
}

# Get list of flatpaks
function ls-flatpaks() {
    flatpak list --columns=application "${@}" | tail -n +1
}

# List of attached hardware
function ls-hardware() {
    lshw "${@}"
}

# Home
function home() { cd "${HOME}" || return 1; }

# Audio
function restart-bluetooth() {
    systemctl restart --user bluetooth
}
function restart-pipewire() {
    systemctl restart --user pipewire
    systemctl restart --user pipewire-pulse
    restart-bluetooth
}

# Default apps
function terminal() { ${TERMINAL} "${@}"; }
function browser() { ${BROWSER} "${@}"; }
function auth() { ${AUTH} "${@}"; }
