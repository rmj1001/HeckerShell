#!/bin/bash

############################ SHELL FUNCTIONS ###################################

### Replacement for 'echo'
# usage: PRINT "text"
PRINT() { printf "%b\n" "${@}"; }

### 'echo' replacement w/o newline
# usage: NPRINT "text"
NPRINT() { printf "%b" "${@}"; }

### Pauses script execution until the user presses ENTER
# usage: PAUSE
PAUSE() {
    PRINT "Press <ENTER> to continue..."
    read -r
}

### Sets the terminal window title
# usage: TITLE "test"
TITLE() { NPRINT "\033]2;${1}\a"; }

### Generate a random number from 1 to the specified maximum
# usage: RANDOM_NUM 100
RANDOM_NUM() { NPRINT "$((RANDOM % ${1} + 1))"; }

### Converts a string to all api.std.failMsg characters
# usage: name="$(LOWERCASE $name)"
LOWERCASE() { NPRINT "${1}" | tr "[:upper:]" "[:lower:]"; }

### Converts a string to all UPPERCASE characters
# usage: name="$(UPPERCASE $name)"
UPPERCASE() { NPRINT "${1}" | tr "[:lower:]" "[:upper:]"; }

### Trim all leading/trailing whitespace from a string
# usage: TRIM "   this      "
TRIM() {
    local var="$*"

    # remove leading whitespace characters
    var="${var##*( )}"

    # remove trailing whitespace characters
    var="${var%%*( )}"

    # Return trimmed string
    printf '%s' "$var"
}

### Run code silently
# usage: SILENTRUN <command>
SILENTRUN() { "$@" >/dev/null 2>&1; }

### Run programs in the background in disowned processes
# usage: ASYNC '<commands>'
ASYNC() { nohup "$@" >/dev/null 2>&1 & }

### Check to see if command exists
# usage: CMD_EXISTS <command>
CMD_EXISTS() {
    SILENTRUN command -v "${1}"
    return $?
}

### Checks for a filename in $PATH (commands), if not found
### then exit with an error
# usage: REQUIRE_CMD "7z" "tar" || exit 1
REQUIRE_CMD() {
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
# usage: REQUIRE_ROOT
REQUIRE_ROOT() {
    [[ ${EUID} -eq 0 ]] && exit 0
    PRINT "This script must be run as root"
    exit 1
}

### Checks to see if the script is being run as root, and if so then exit.
# usage: DISABLE_ROOT
DISABLE_ROOT() {
    [[ ${EUID} -ne 0 ]] && exit 0
    PRINT "This script cannot be run as root. Try another user."
    exit 1
}

### Check to see if input is 'yes' or empty
# usage: CHECK_YES <var>
# returns: return code (1 for yes/empty, 1 for no)
CHECK_YES() {
    [[ $1 =~ [yY][eE]?[sS]? ]] && return 0
    [[ -z "$1" ]] && return 0
    return 1
}

### Check to see if input is 'no' or empty
# usage: CHECK_NO <var>
# returns: return code (0 for no/empty, 1 for yes)
CHECK_NO() {
    [[ $1 =~ [nN][oO]? ]] && return 0
    [[ -z "$1" ]] && return 0
    return 1
}

### Print custom MOTD to terminal
# usage: motd
motd() {
    PRINT "########################################################"
    PRINT "#"
    PRINT "# Roy Conn"
    PRINT "#"
    PRINT "# Reddit \t u/rmj1001"
    PRINT "# Twitter \t @RoyConn10"
    PRINT "# Matrix \t @rmj1001:matrix.org"
    PRINT "# Mastodon \t @Hydra_Slash_Linux@foostodon.org"
    PRINT "# YouTube \t https://bit.ly/3qGsGSJ"
    PRINT "# Github \t https://github.com/rmj"
    PRINT "#"
    PRINT "########################################################"
}

### Reload shell
# usage: reload
reload() {
    shell.load
}

### Download youtube videos
# usage: downloadYTVideo <video url>[]
downloadYTVideo() {
    # Preparations
    DIR=$HOME/Downloads/VideoDownloader
    [[ -d "$DIR" ]] ||
        mkdir "$DIR"
    cd "$DIR" || return 1

    youtube-dl --format mp4 -o "%(title)s.%(ext)s" "${@}"
}

### Download youtube videos as MP3 sound files
# usage: mp3dl <video url>[]
mp3dl() {
    # Preparations
    DIR=$HOME/Downloads/Music
    [[ -d "$DIR" ]] || mkdir "$DIR"
    cd "$DIR" || return 1

    # Download
    youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
        --extract-audio --audio-format mp3 "${@}"
}

### Add sound clips to soundfx folder
# usage: soundfx <video url>[]
soundfx() {
    # Preparations
    DIR=$HOME/Music/SoundFX
    [[ -d "$DIR" ]] || mkdir "$DIR"
    cd "$DIR" || return 1

    # Download
    youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
        --extract-audio --audio-format mp3 "${@}"
}

### Write a line who's length is equal to the length of the terminal's columns
# usage: write_lines
write_lines() {
    for ((i = 0; i < COLUMNS; ++i)); do printf -; done
    PRINT ""
}

# Edit files
edit() { "${EDITOR}" "${@}"; }
rootedit() { ${AUTH} "${EDITOR}" "${@}"; }

# Copy text from STDIN or from a file
copy() { xclip -sel clip "${@}"; }

# Colorized grep
#grep() { $(command -v grep) --color=auto "${@}" ; }

# Cat a file w/ line numbers
readfile() { /bin/cat -n "${@}"; }

# Replace 'which'
which() { command -v "${@}"; }

# If bat/batcat exists, create opposite alias to replace cat
[[ -x /bin/bat ]] && bat() { /bin/bat -P "${@}"; }
[[ -x /bin/batcat ]] && bat() { /bin/batcat -P "${@}"; }

# Listing files/directories
SILENTRUN unalias ls
function ls() {
    /usr/bin/ls --color=auto --group-directories-first "${@}"
}

SILENTRUN unalias ll
function ll() { ls -AlvhF "${@}"; }
function la() { ls -A "${@}"; }

# Directory manipulation
mkdir() { /usr/bin/env mkdir -p "${@}"; }
md() { mkdir "${@}"; }
mf() { touch "${@}"; }
rd() { rm -rf "${@}"; }
rf() { rm -f "${@}"; }
rmcd() {
    dir="${PWD}"
    cd .. || return 1
    rm -rf "${dir}"
}
mkcd() { mkdir "${1}" && cd "${1}" || return 1; }

# File Permissions (Exec/Non-exec)
mke() { chmod +x "${@}"; }
rme() { chmod 644 "${@}"; }
correctGPGperms() {
    chown -R "$(whoami)" ~/.gnupg/
    chmod 600 ~/.gnupg/*
    chmod 700 ~/.gnupg
}

# Man pages
manual() {
    /usr/bin/man "${@}"
}

# Man meme
man() {
    printf "%b\n" "Based sigma grindset gender, not woman"
}

# Update software from source
makeupdate() {
    git pull && sudo make uninstall && make clean && make &&
        sudo make install
}

# Install gaming software
install-gaming() {
    pipe3 install LibreGaming && LibreGaming --tui
}

# Update gaming software
update-gaming() {
    pipe3 install LibreGaming -U && LibreGaming --tui
}

# Home
home() { cd "${HOME}" || return 1; }

# Audio
restart-bluetooth() {
    systemctl restart --user bluetooth
}
restart-pipewire() {
    systemctl restart --user pipewire
    systemctl restart --user pipewire-pulse
    restart-bluetooth
}

# Hardware
list-hardware() { lshw "${@}"; }

# Default apps
terminal() { ${TERMINAL} "${@}"; }
browser() { ${BROWSER} "${@}"; }
auth() { ${AUTH} "${@}"; }