#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: 00-api.sh
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Functions for manipulating
#   STD(IN/OUT/ERR) or other programs
#
##############################################

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
