#!/usr/bin/env bash

##############################################
#	Author: Nidia Achrys
#	Project: api.sh
#	Version: 1.0
# 
# 	Description:
#   	This script provides a basic API for other
#		bash scripts, to make their development
#		easier and more consistent.
##############################################

# ---------------------------------------------------------------------------------
# Rules																			
# ---------------------------------------------------------------------------------
# 1. Function names should be lowercase
# 2. Functions should have comments above them declaring their purpose and usage
# 3. Variables in functions should be declared as local
# 4. No global variables should be available in the API
# 5. If functions assume global variables exist, make sure to include a default
#    value if it doesn't. i.e. ${version:=1.0}, where 1.0 is the default
# ---------------------------------------------------------------------------------

source $SCRIPTS/headers/01-class.sh

class "api"

###################### SCRIPT INFORMATION ######################

# Description: Retrieve the name of the script file
#
# Usage: name=`api.SCRIPTNAME`
api.SCRIPTNAME ()
{
	local absolute="`readlink -f ${0}`"
	
	api.PRINT "${absolute##*/}"
	return 0
}

# Description: Retrieve the name of the directory the script file is run in
#
# Usage: parent=`api.SCRIPTDIR`
api.SCRIPTDIR ()
{
	local absolute="`readlink -f ${0}`"

	api.PRINT "$( dirname ${absolute} )"
	return 0
}

# Description: Prints the script name and version, as well as copyright, 
# license notice, and author name
#
# Usage: api.VERSION
api.VERSION ()
{
	api.PRINT "`api.SCRIPTNAME` v${version:=1.0}"
	api.PRINT "Copyright (C) `date +"%Y"` ${author:=Some Random Scripter}"
	api.PRINT "License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>."
	api.PRINT "This is free software: you are free to change and redistribute it."
	api.PRINT "There is NO WARRANTY, to the extent permitted by law."
	api.PRINT
	api.PRINT "Written by ${author:=Some Random Scripter}."
	return 0
}

###################### INTERACTIVITY ######################

# Description: Replacement for 'echo'
#
# Usage: api.PRINT "text"
api.PRINT ()
{
	if [ -z "${1}" ]; then
		printf "\n"
	else
		printf "%b\n" "${1}"
	fi

	return 0
}

# Description: Pauses script execution until the user presses ENTER
#
# Usage: api.PAUSE
api.PAUSE ()
{
	read -p "Press ENTER to continue..." cmd
	return 0
}

# Description: Send a log message to the terminal
#
# Usage: api.LOG "api.This is awesome!"
api.LOG ()
{
	api.PRINT "`api.SCRIPTNAME`: ${@}"
}

# Description: Send an error message and give a return code of 1
#
# Usage: api.ERROR "api.This broke!"
api.ERROR ()
{
	api.LOG "${@}" && return 1
}

# Description: Send an error message, exit, and give a return code of 1
#
# Usage: api.FAIL "This script broke!"
api.FAIL ()
{
	api.LOG "${@}" && exit 1
}

###################### STRING MANIPULATION ######################

# Description: Converts a string to all api.FAIL characters
#
# Usage: name=`api.LOWERCASE $name`
api.LOWERCASE ()
{
	printf "${1}" | tr "[:upper:]" "[:lower:]"
	return 0
}

# Description: Converts a string to all UPPERCASE characters
#
# Usage: name=`api.UPPERCASE $name`
api.UPPERCASE ()
{
	printf "${1}" | tr "[:lower:]" "[:upper:]"
	return 0
}

# Description: Trim all leading/trailing whitespace from a string
#
# Usage: api.TRIM "   this      "
api.TRIM ()
{
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   
    printf '%s' "$var"
}

###################### SCRIPT PREPROCCESSORS & PERMISSION CHECKING ######################

# Description: Error message for when an invalid command is used
#
# Usage: api.INVALID "hlep"
api.INVALID ()
{
	api.FAIL "Invalid command \"${1}\". See \"`api.SCRIPTNAME` help\"."
}

# Description: Error message for when no command is used
#
# Usage: api.EMPTYCMD
api.EMPTYCMD ()
{ 
	api.FAIL "You must specify a subcommand. See \"`api.SCRIPTNAME` help\"."
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: api.DEPENDENCY "7z"
api.DEPENDENCY ()
{
	[[ ! `command -v ${1}` ]] && api.FAIL "'${1}' is required to run this program."
}

# Description: Checks to see if the script is being run as root, and if not then exit.
#
# Usage: api.ROOT
api.ROOT ()
{
	if [[ $EUID -ne 0 ]]
	then
		api.FAIL "This script must be run as root"
	fi
}
