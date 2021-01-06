#!/usr/bin/env bash

##############################################
#	Author: Nidia Achrys
#	Library: api.sh
#	Version: 1.0
# 
# 	Description:
#   	This script provides a basic API for other
#		bash scripts, to make their development
#		easier and more consistent.
##############################################

# Create an API class
source $SCRIPTS/libs/class/class.sh

class "api"

###################### SCRIPT INFORMATION ######################

# Variables
SCRIPT_AUTHOR="Some Random Dude"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="Some Random Description"
SCRIPT_USAGE="[args]"
SCRIPT_EXAMPLES=()
SCRIPT_OPTIONS=()
SCRIPT_SETTINGS=()

# Description: Retrieve the name of the script file
#
# Usage: name=`api.script.name`
api.script.name ()
{
	local absolute="`readlink -f ${0}`"
	
	api.std.printLn "${absolute##*/}"
	return 0
}

# Description: Retrieve the name of the directory the script file is run in
#
# Usage: parent=`api.script.directory`
api.script.directory ()
{
	local absolute="`readlink -f ${0}`"

	api.std.printLn "$( dirname ${absolute} )"
	return 0
}

# Description: Set the script's description for the help menu
#
# Usage: api.script.author "dude"
api.script.author ()
{
	SCRIPT_AUTHOR="${1}"
}

# Description: Set the script's version for the help menu
#
# Usage: api.script.version "1.0"
api.script.setVersion ()
{
	SCRIPT_VERSION="${1}"
}

# Description: Set the script's description for the help menu
#
# Usage: api.script.description "some text"
api.script.description ()
{
	SCRIPT_DESCRIPTION="${1}"
}

# Description: Set the script's usage for the help menu
#
# Usage: api.script.usage "some text"
api.script.usage ()
{
	SCRIPT_USAGE="${1}"
}

# Description: Add a script usage example for the help menu
#
# Usage: api.script.example "some text"
api.script.example ()
{
	SCRIPT_EXAMPLES+=( "${1}" )
}

# Description: Add a script command for the help menu
#
# Usage: api.script.option "some text"
api.script.option ()
{
	local entry="($1) $2 \n  - $3"
	SCRIPT_OPTIONS+=( "${entry}" )
}

# Description: Add a script setting command for the help menu
#
# Usage: api.script.setting "some text"
api.script.setting ()
{
	local entry="($1) $2 \n  - $3"
  	SCRIPT_SETTINGS+=( "${entry}" )
}

# Description: Automatically generate and print a help menu for the script
#
# Usage: api.script.help
api.script.help ()
{
  api.std.printLn "${SCRIPT_DESCRIPTION}\n"
  api.std.printLn "Usage: `api.script.name` ${SCRIPT_USAGE:=[args]}"

  # Examples
  if [ ${#SCRIPT_EXAMPLES[@]} -gt 0 ]; then
    
    for example in "${SCRIPT_EXAMPLES[@]}"; do
      api.std.printLn "Example: `api.script.name` ${example}"
    done

  fi
  
  # CLI options
  if [ ${#SCRIPT_OPTIONS[@]} -gt 0 ]; then
  
    api.std.printLn 
    api.std.printLn "Commands"

	for entry in "${SCRIPT_OPTIONS[@]}"; do
		api.std.printLn "${entry}"
	done
  
  fi

  # Script Settings
  if [ ${#SCRIPT_SETTINGS[@]} -gt 0 ]; then
  
    api.std.printLn 
    api.std.printLn "Settings"

    for entry in "${SCRIPT_SETTINGS[@]}"; do
      api.std.printLn "${entry}"
    done
  
  fi

  # Miscellaneous
  api.std.printLn 
  api.std.printLn "Miscellaneous"
  api.std.printLn "(h) help\n  - Show this help menu"
  api.std.printLn "(v) version\n  - Show the script version"
}

# Description: Prints the script name and version, as well as copyright, 
# license notice, and author name
#
# Usage: api.script.version
api.script.version ()
{
	api.std.printLn 
  	api.std.printLn "`api.script.name` v${SCRIPT_VERSION}"
	api.std.printLn "Copyright (C) `date +"%Y"` ${SCRIPT_AUTHOR}"
	api.std.printLn "License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>."
	api.std.printLn "This is free software: you are free to change and redistribute it."
	api.std.printLn "There is NO WARRANTY, to the extent permitted by law."
	api.std.printLn
	api.std.printLn "Written by ${SCRIPT_AUTHOR}."
  api.std.printLn 
	return 0
}

###################### INTERACTIVITY ######################

# Description: Replacement for 'echo'
#
# Usage: api.std.printLn "text"
api.std.printLn ()
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
# Usage: api.std.pause
api.std.pause ()
{
	read -p "Press ENTER to continue..." cmd
	return 0
}

# Description: Send a log message to the terminal
#
# Usage: api.std.logMsg "api.This is awesome!"
api.std.logMsg ()
{
	api.std.printLn "`api.script.name`: ${@}"
}

# Description: Send an error message and give a return code of 1
#
# Usage: api.std.errorMsg "api.This broke!"
api.std.errorMsg ()
{
	api.std.logMsg "${@}" && return 1
}

# Description: Send an error message, exit, and give a return code of 1
#
# Usage: api.std.failMsg "This script broke!"
api.std.failMsg ()
{
	api.std.logMsg "${@}" && exit 1
}

# Description: Generate a random number from 1 to the specified maximum
#
# Usage: api.std.randomNumber 100
api.std.randomNumber ()
{
	printf "%b" "$(( ${RANDOM} % ${1} + 1 ))"
}

###################### STRING MANIPULATION ######################

# Description: Converts a string to all api.std.failMsg characters
#
# Usage: name=`api.string.toLowerCase $name`
api.string.toLowerCase ()
{
	printf "${1}" | tr "[:upper:]" "[:lower:]"
	return 0
}

# Description: Converts a string to all UPPERCASE characters
#
# Usage: name=`api.string.toUpperCase $name`
api.string.toUpperCase ()
{
	printf "${1}" | tr "[:lower:]" "[:upper:]"
	return 0
}

# Description: Trim all leading/trailing whitespace from a string
#
# Usage: api.string.trim "   this      "
api.string.trim ()
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
# Usage: api.errors.invalidCommand "hlep"
api.errors.invalidCommand ()
{
	api.std.failMsg "Invalid command \"${1}\". See \"`api.script.name` help\"."
}

# Description: Error message for when no command is used
#
# Usage: api.errors.emptyCommand
api.errors.emptyCommand ()
{ 
	api.std.failMsg "You must specify a subcommand. See \"`api.script.name` help\"."
}

# Description: Checks for a filename in $PATH (commands), if not found then exit with an error
#
# Usage: api.required.command "7z"
api.required.command ()
{
	[[ ! `command -v ${1}` ]] && api.std.failMsg "'${1}' is required to run this program."
}

# Description: Checks to see if the script is being run as root, and if not then exit.
#
# Usage: api.required.root
api.required.root ()
{
	if [[ $EUID -ne 0 ]]
	then
		api.std.failMsg "This script must be run as root"
	fi
}

###################### LIBRARY SUPPORT ######################

# Description: Sources all script files from a directory
# under $SCRIPTS/libs
#
# Usage: api.lib.import "libraryName"
api.lib.import ()
{
	local libname="`api.string.toLowerCase ${1}`"
	local dir="${SCRIPTS}/libs/${libname}"

	if [ -d "${dir}" ]
	then

		for file in ${dir}/*
		do
		
			source $file
		
		done
	
	else

		api.std.failMsg "Invalid library '${libname}'"
	
	fi
}
