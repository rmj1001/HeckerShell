#!/usr/bin/env bash

##############################################
#   Author(s): name <email@domain.com>
#   Project:
#   Version: 1.0
#
#   Usage:
#
#   Description:
#
##############################################

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

# Preprocessing flags
DISABLE_ROOT || exit 1
REQUIRE_CMD "" || exit 1

####################################

function _help() {
	PRINT "$(SCRIPTNAME) - description"
	PRINT
	PRINT "Usage:\t\t$(SCRIPTNAME) [FLAGS] [ARGS?] ..."
	PRINT "Example:\t$(SCRIPTNAME) --help"
	PRINT
	{
		PRINT "-------------|------|---------------------"
		PRINT "Flag|Args|Description"
		PRINT "-------------|------|---------------------"
		PRINT "||"
		PRINT "-h, --help|n/a|Show this prompt"
	} | column -t -s'|'
}

# If no arguments are give, just show help prompt.
[[ $# -eq 0 ]] && _help && exit 0

# Iterate over all arguments and evaluate them
while [[ $# -gt 0 ]]; do

	case "$(LOWERCASE "${1}")" in

	\? | -h | --help)
		shift
		_help
		exit 0
		;;

	*) INVALID_CMD "${1}" && exit 1 ;;

	esac

done
