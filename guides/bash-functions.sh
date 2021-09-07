#!/usr/bin/env bash

##############################################
#	Author: Nidia Achrys
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
PRINT()
{
	printf "%b\n" "${@}"
}

# Description: 'echo' replacement w/o newline
#
# Usage: NPRINT "text"
NPRINT()
{
	printf "%b" "${@}"
}

# Description: Pauses script execution until the user presses ENTER
#
# Usage: PAUSE
PAUSE ()
{
	read -r -p "Press <ENTER> to continue..."

	return 0
}

# Description: Sets the terminal window title
#
# Usage: TITLE "test"
TITLE ()
{
	printf "%b" "\033]2;${1}\a"
}

# Description: Generate a random number from 1 to the specified maximum
#
# Usage: RANDOM_NUM 100
RANDOM_NUM ()
{
	printf "%b" "$(( RANDOM % ${1} + 1 ))"
}

# Description: Converts a string to all api.std.failMsg characters
#
# Usage: name="$(LOWERCASE $name)"
LOWERCASE ()
{
	printf "%b" "${1}" | tr "[:upper:]" "[:lower:]"
	return 0
}

# Description: Converts a string to all UPPERCASE characters
#
# Usage: name="$(UPPERCASE $name)"
UPPERCASE ()
{
	printf "%b" "${1}" | tr "[:lower:]" "[:upper:]"
	return 0
}

# Description: Trim all leading/trailing whitespace from a string
#
# Usage: TRIM "   this      "
TRIM ()
{
    local var="$*"

    # remove leading whitespace characters
    var="${var##*( )}"
    
	# remove trailing whitespace characters
    var="${var%%*( )}"
    
    # Return trimmed string
    printf '%s' "$var"
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: REQUIRE_CMD "7z" "tar"
REQUIRE_CMD ()
{
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
REQUIRE_ROOT ()
{
	if [[ $EUID -ne 0 ]]
	then
		printf "%b\n" "This script must be run as root"
		exit 1
	fi
}
