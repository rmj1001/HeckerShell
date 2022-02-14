#!/usr/bin/env bash

##############################################
#	Author(s): RMCJ <rmichael1001@gmail.com>
#	Project: HeckerShell
#	Version: 1.0
#
# 	Description:
#   	This file provides common bash functions
#		that I use in all my bash scripts. Feel free
#		to use these functions in your own scripts.
##############################################

# Description: Replacement for 'echo'
#
# Usage: PRINT "text"
# Returns: string
function PRINT() {
    printf "%b\n" "${@}"
}

# Description: 'echo' replacement w/o newline
#
# Usage: NPRINT "text"
# Returns: string
function NPRINT() {
    printf "%b" "${@}"
}

# Description: Pauses script execution until the user presses ENTER
#
# Usage: PAUSE
# Returns: int
function PAUSE() {
    NPRINT "Press <ENTER> to continue..." && read -r
}

# Description: Sets the terminal window title
#
# Usage: TITLE "test"
# Returns: void
function TITLE() {
    NPRINT "\033]2;${1}\a"
}

# Description: Generate a random number from 1 to the specified maximum
#
# Usage: RANDOM_NUM 100
# Returns: int
function RANDOM_NUM() {
    eval "shuf -i 1-${1} -n 1"
}

# Description: Converts a string to all api.std.failMsg characters
#
# Usage: name="$(LOWERCASE $name)"
# Returns: string
function LOWERCASE() {
    NPRINT "${1}" | tr "[:upper:]" "[:lower:]"
}

# Description: Converts a string to all UPPERCASE characters
#
# Usage: name="$(UPPERCASE $name)"
# Returns: string
function UPPERCASE() {
    NPRINT "${1}" | tr "[:lower:]" "[:upper:]"
}

# Description: Trim all leading/trailing whitespace from a string
#
# Usage: TRIM "   this      "
# Returns: string
function TRIM() {
    var="$*"

    # remove leading whitespace characters
    var="${var##*( )}"

    # remove trailing whitespace characters
    var="${var%%*( )}"

    # Return trimmed string
    printf '%s' "$var"
}

# Description: Return the name of the script
#
# Usage: SCRIPTNAME
# Returns: string
function SCRIPTNAME() {
    NPRINT "$(basename "$(readlink -nf "$0")")"
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: REQUIRE_CMD "7z" "tar" || exit 1
# Returns: string
function REQUIRE_CMD() {
    NEEDED=()

    for arg in "${@}"; do
        command -v "${arg}" >/dev/null 2>&1 || NEEDED+=("${arg}")
    done

    test ${#NEEDED[@]} -eq 0 && return 0

    PRINT "The following programs are required to run this program:"
    PRINT "${NEEDED[@]}"
    return 1
}

# Description: Checks to see if the script is being run as root, and if not then exit.
#
# Usage: REQUIRE_ROOT
# Returns: string
function REQUIRE_ROOT() {
    # shellcheck disable=SC2046
    test $(id -u) -eq 0 && return 0

    PRINT "'$(SCRIPTNAME)' must be run as root"
    exit 1
}

# Description: Checks to see if the script is being run as root, and if so then exit.
#
# Usage: DISABLE_ROOT
# Returns: string
function DISABLE_ROOT() {
    # shellcheck disable=SC2046
    test $(id -u) -ne 0 && return 0

    PRINT "'$(SCRIPTNAME)' should not be run as root. Please try again as a normal user."
    exit 1
}

# Description: Run code silently
#
# Usage: SILENTRUN <command>
# Returns: return exit code
function SILENTRUN() {
    "$@" >/dev/null 2>&1
}

# Description: Run code silently and disown it
#
# Usage: ASYNC <command>
# Returns: void
function ASYNC() {
    "$@" >/dev/null 2>&1 &
    disown
}

# Description: Check to see if command exists
#
# Usage: CMD_EXISTS <command>
# Returns: return code
function CMD_EXISTS() {
    command -v "${1}" >/dev/null 2>&1
}

# Description: Check to see if input is 'yes' or empty
#
# Usage: CHECK_YES <var>
# Returns: return code (1 for yes/empty, 1 for no)
function CHECK_YES() {
    echo "$1" | grep -Eq '[yY][eE]?[sS]?' && return 0
    test -z "$1" && return 0
    return 1
}

# Description: Check to see if input is 'no' or empty
#
# Usage: CHECK_NO <var>
# Returns: return code (0 for no/empty, 1 for yes)
function CHECK_NO() {
    echo "$1" | grep -Eq '[nN][oO]?' && return 0
    test "$1" != "" && return 0
    return 1
}

# Description: Checks to see if input is a number
#
# Usage: IS_NUMBER <var>
# Returns: return code (0 for yes, 1 for no)
function IS_NUMBER() {
    echo "$1" | grep -Eq '[0-9]+' && return 0
    return 1
}

# Description: Find the path for a command
#
# Usage: WHICH <cmd>
# Returns: string
function WHICH() {
    command -v "${@}"
}

# Description: Read config file using ini-esque format
#
# Usage: READ_CONF <file>
# Returns: void (reads file and inits variables in script from file)
function READ_CONF() {

    RCfile="${1}"
    section=""
    var=""
    val=""

    # If file doesn't exist, return with error.
    [ ! -f "${RCfile}" ] && PRINT "$(SCRIPTNAME): Invalid file ${RCfile}." && return 1

    # Read file line-by-line
    while read -r line; do

        line="$(TRIM "${line}")"

        # Continue to next line if commented
        echo "$line" | grep -Eq '^#\.*' && continue

        # If line is a section, set `$section` variable and continue to next line
        echo "$line" | grep -Eq '^\[[a-z]+\]$' && section="$(NPRINT "${line}" | sed -e 's|\[\([a-z]\+\)\]|\1|')" && continue

        # If line is a key=value pair, then set `var` and `val` accordingly, else continue to next line.
        echo "$line" | grep -Eq "^[a-z]+\=\"?\'?.*\"?\'?$" || continue
        echo "$line" | grep -Eq "^[a-z]+\=\"?\'?.*\"?\'?$" &&
            var="$(NPRINT "${line}" | sed 's|\([a-z]\+\)\=.*|\1|')" &&
            val="$(NPRINT "${line}" | sed 's|.*\=||g' | cut -d\" -f2 | cut -d\' -f2)"

        # If no section, import as `var="val"`
        [ -z "${section}" ] && eval "${var}=\"${val}\"" && continue

        # If section, import as `section.var="val"`
        eval "${section}_${var}=\"${val}\""

    done <"${RCfile}"
}
