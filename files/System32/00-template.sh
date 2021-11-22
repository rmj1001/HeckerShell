#!/usr/bin/env bash

##############################################
#   Author: Roy Conn
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
DISABLE_ROOT
REQUIRE_CMD "" || exit 1

####################################

_help() {
	_flags() {
		PRINT "-------------|------|---------------------"
		PRINT "Flag|Args|Description"
		PRINT "-------------|------|---------------------"
		PRINT "||"
		PRINT "-h, --help|n/a|Show this prompt"
	}

	PRINT "$(SCRIPTNAME) - description"
	PRINT
	PRINT "Usage:\t\t$(SCRIPTNAME) <flag> <args?>"
	PRINT "Example:\t$(SCRIPTNAME) --help"
	PRINT
	_flags | column -t -s'|'
}

# If no arguments are give, just show help prompt.
[[ $# -eq 0 ]] && _help && exit 0

# Iterate over all arguments and evaluate them
while test $# -gt 0; do

	case "$(LOWERCASE "${1}")" in

	\? | -h | --help)
		shift
		_help
		exit 0
		;;

	*) PRINT "$(SCRIPTNAME): Invalid argument '${1}'" && exit 1 ;;

	esac

done
