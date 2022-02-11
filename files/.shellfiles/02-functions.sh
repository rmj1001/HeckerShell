#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: 02-functions.sh
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Dotfiles functions
#
##############################################

############################ SHELL FUNCTIONS ###################################

### Replacement for 'echo'
# Usage: PRINT "text"
function PRINT() { printf "%b\n" "${@}"; }

### 'echo' replacement w/o newline
# Usage: NPRINT "text"
function NPRINT() { printf "%b" "${@}"; }

### Pauses script execution until the user presses ENTER
# Usage: PAUSE
function PAUSE() {
    PRINT "Press <ENTER> to continue..."
    read -r
}

### Sets the terminal window title
# Usage: TITLE "test"
function TITLE() { NPRINT "\033]2;${1}\a"; }

### Generate a random number from 1 to the specified maximum
# Usage: RANDOM_NUM 100
function RANDOM_NUM() { NPRINT "$((RANDOM % ${1} + 1))"; }

### Converts a string to all api.std.failMsg characters
# Usage: name="$(LOWERCASE $name)"
function LOWERCASE() { NPRINT "${1}" | tr "[:upper:]" "[:lower:]"; }

### Converts a string to all UPPERCASE characters
# Usage: name="$(UPPERCASE $name)"
function UPPERCASE() { NPRINT "${1}" | tr "[:lower:]" "[:upper:]"; }

### Trim all leading/trailing whitespace from a string
# Usage: TRIM "   this      "
function TRIM() {
    local var="$*"

    # remove leading whitespace characters
    var="${var##*( )}"

    # remove trailing whitespace characters
    var="${var%%*( )}"

    # Return trimmed string
    printf '%s' "$var"
}

### Run code silently
# Usage: SILENTRUN <command>
function SILENTRUN() { "$@" >/dev/null 2>&1; }

### Run programs in the background in disowned processes
# Usage: ASYNC '<commands>'
function ASYNC() { nohup "$@" >/dev/null 2>&1 & }

### Check to see if command exists
# Usage: CMD_EXISTS <command>
function CMD_EXISTS() {
    SILENTRUN command -v "${1}"
    return $?
}

### Checks for a filename in $PATH (commands), if not found
### then exit with an error
# Usage: REQUIRE_CMD "7z" "tar" || exit 1
function REQUIRE_CMD() {
    NEEDED=()

    for arg in "${@}"; do
        CMD_EXISTS "${arg}" || NEEDED+=("${arg}")
    done

    [[ ${#NEEDED[@]} -lt 1 ]] && exit 0

    PRINT "The following programs are required to run this program:"
    PRINT "${NEEDED[@]}"

    return 1
}

### Checks to see if the script is being run as root, and if not then exit.
# Usage: REQUIRE_ROOT
function REQUIRE_ROOT() {
    [[ ${EUID} -eq 0 ]] && exit 0
    PRINT "This script must be run as root"
    exit 1
}

### Checks to see if the script is being run as root, and if so then exit.
# Usage: DISABLE_ROOT
function DISABLE_ROOT() {
    [[ ${EUID} -ne 0 ]] && exit 0
    PRINT "This script cannot be run as root. Try another user."
    exit 1
}

### Check to see if input is 'yes' or empty
# Usage: CHECK_YES <var>
# returns: return code (1 for yes/empty, 1 for no)
function CHECK_YES() {
    [[ $1 =~ [yY][eE]?[sS]? ]] && return 0
    [[ -z "$1" ]] && return 0
    return 1
}

### Check to see if input is 'no' or empty
# Usage: CHECK_NO <var>
# returns: return code (0 for no/empty, 1 for yes)
function CHECK_NO() {
    [[ $1 =~ [nN][oO]? ]] && return 0
    [[ -z "$1" ]] && return 0
    return 1
}

### Find the path for a command
# Usage: WHICH <command>
# returns: string
function WHICH() {
    command -v "${@}"
}

### Write a line who's length is equal to the length of the terminal's columns
# Usage: write_lines
function write_lines() {
    for ((i = 0; i < COLUMNS; ++i)); do printf -; done
    PRINT ""
}

### Clear screen and print MOTD
## [flag] --no-clear: do not clear screen when printing
# Usage: freshscreen <flag?>
function freshscreen() {
    [[ "$(LOWERCASE "${1}")" == "--no-clear" ]] || clear

    motd

    [[ "${SHELL}" == "/bin/zsh" ]] && printf "%b\n" ""
}

### Reload shell
## [flag] --clean: Restart shell completely, not just reload dotfiles
# Usage: reload <flag>
function reload() {
    # If clean flag isn't used then just reload sourced files
    [[ "$(LOWERCASE "${1}")" == "--clean" ]] || {
        shell.load
        return 0
    }

    # If clean flag is used then exec/restart the shell
    exec "$(basename "${SHELL}")"
}

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
