#!/usr/bin/env bash

##############################################
#	Author: Dark Lord Meowron
#	Library: api.sh
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
PRINT() {
	printf "%b\n" "${@}"
}

# Description: 'echo' replacement w/o newline
#
# Usage: NPRINT "text"
# Returns: string
NPRINT() {
	printf "%b" "${@}"
}

# Description: Pauses script execution until the user presses ENTER
#
# Usage: PAUSE
# Returns: int
PAUSE() {
	read -r -p "Press <ENTER> to continue..."

	return 0
}

# Description: Sets the terminal window title
#
# Usage: TITLE "test"
# Returns: void
TITLE() {
	printf "%b" "\033]2;${1}\a"
}

# Description: Generate a random number from 1 to the specified maximum
#
# Usage: RANDOM_NUM 100
# Returns: int
RANDOM_NUM() {
	printf "%b" "$((RANDOM % ${1} + 1))"
}

# Description: Converts a string to all api.std.failMsg characters
#
# Usage: name="$(LOWERCASE $name)"
# Returns: string
LOWERCASE() {
	printf "%b" "${1}" | tr "[:upper:]" "[:lower:]"
	return 0
}

# Description: Converts a string to all UPPERCASE characters
#
# Usage: name="$(UPPERCASE $name)"
# Returns: string
UPPERCASE() {
	printf "%b" "${1}" | tr "[:lower:]" "[:upper:]"
	return 0
}

# Description: Trim all leading/trailing whitespace from a string
#
# Usage: TRIM "   this      "
# Returns: string
TRIM() {
	local var="$*"

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
SCRIPTNAME() {
	printf "%b" "$(basename $(readlink -nf $0))"
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: REQUIRE_CMD "7z" "tar"
# Returns: string
REQUIRE_CMD() {
	NEEDED=()

	for arg in "${@}"; do
		if [[ ! -x "$(which "$arg")" ]]; then

			NEEDED+=("${arg}")

		fi
	done

	if [[ ${#NEEDED[@]} -gt 0 ]]; then
		printf "%b\n" "The following programs are required to run this program:"
		printf "%b\n" "${NEEDED[@]}"

		exit 1
	fi
}

# Description: Checks to see if the script is being run as root, and if not then exit.
#
# Usage: REQUIRE_ROOT
# Returns: string
REQUIRE_ROOT() {
	if [[ $EUID -ne 0 ]]; then
		printf "%b\n" "This script must be run as root"
		exit 1
	fi
}

# Description: Checks to see if the script is being run as root, and if so then exit.
#
# Usage: DISABLE_ROOT
# Returns: string
DISABLE_ROOT() {
	if [[ $EUID -eq 0 ]]; then

		PROGRAM_NAME="$(basename "$0")"

		PRINT "'${PROGRAM_NAME}' should not be run as root. Please try again as a normal user."
		exit 1
	fi
}

# Description: Check to see if command exists
#
# Usage: CMD_EXISTS <command>
# Returns: return code
CMD_EXISTS() {
	command -v "${1}" >/dev/null 2>&1
	return $?
}

# Description: Check to see if input is 'yes' or empty
#
# Usage: CHECK_YES <var>
# Returns: return code (1 for yes/empty, 1 for no)
CHECK_YES() {
	[[ $1 =~ [yY][eE]?[sS]? ]] && return 0
	[[ -z "$1" ]] && return 0
	return 1
}

# Description: Check to see if input is 'no' or empty
#
# Usage: CHECK_NO <var>
# Returns: return code (0 for no/empty, 1 for yes)
CHECK_NO() {
	[[ $1 =~ [nN][oO]? ]] && return 0
	[[ -z "$1" ]] && return 0
	return 1
}

