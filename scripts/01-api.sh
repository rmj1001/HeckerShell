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

# |---------------------------------------------------------------------------------|
# |Rules																			|
# |---------------------------------------------------------------------------------|
# |1. Function names should be lowercase											|
# |2. Functions should have comments above them declaring their purpose and usage   |
# |3. Variables in functions should be declared as local							|
# |4. No global variables should be available in the API							|
# |---------------------------------------------------------------------------------|


# Description: Replacement for 'echo'
#
# Usage: PRINT "text"
function PRINT()
{
	if [ -z "${1}" ]; then
		printf "\n"
	else
		printf "%b\n" "${1}"
	fi

	return 0
}

# Description: Retrieve the name of the script file
#
# Usage: name=`SCRIPTNAME`
function SCRIPTNAME()
{
	PRINT "${0##*/}"
	return 0
}

# Description: Pauses script execution until the user presses ENTER
#
# Usage: PAUSE
function PAUSE()
{
	read -p "Press ENTER to continue..." cmd
	return 0
}

# Description: Converts a string to all LOWERCASE characters
#
# Usage: name=`LOWERCASE $name`
function LOWERCASE()
{
	printf "${1}" | tr "[:upper:]" "[:lower:]"
	return 0
}

# Description: Error message for when an invalid command is used
#
# Usage: INVALID "hlep"
function INVALID()
{
	PRINT 
	PRINT "Invalid command \"${1}\". See \"`SCRIPTNAME` help\"."
	PRINT 
	return 1
}

# Description: Error message for when no command is used
#
# Usage: EMPTYCMD
function EMPTYCMD()
{
	PRINT 
	PRINT "You must specify a subcommand. See \"`SCRIPTNAME` help\"."
	PRINT 
	return 1
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: DEPENDENCY "7z"
function DEPENDENCY()
{
	[[ ! `command -v ${1}` ]] && PRINT "'${1}' is required to run this program." && exit 1
}

# Description: Checks to see if the script is being run as root, and if not then exit.
#
# Usage: ROOT
function ROOT()
{
	if [[ $EUID -ne 0 ]]
	then
		PRINT "This script must be run as root" 1>&2
		exit 1
	fi
}

# Description: Prints the script name and version, as well as copyright, 
# license notice, and author name
#
# Usage: VERSION
function VERSION()
{
	PRINT "`SCRIPTNAME` v${version}"
	PRINT "Copyright (C) `date +"%Y"` ${author}"
	PRINT "License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>."
	PRINT "This is free software: you are free to change and redistribute it."
	PRINT "There is NO WARRANTY, to the extent permitted by law."
	PRINT
	PRINT "Written by ${author}."
	return 0
}
