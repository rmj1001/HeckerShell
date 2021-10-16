#!/usr/bin/env bash

##############################################
#   Author:
#   Project:
#   Version: 1.0
#
#   Usage:
#
#   Description:
#
##############################################

# shellcheck disable=SC1091
source "${SCRIPTS}"/00-api.sh

# Preprocessing flags
DISABLE_ROOT

####################################

_help () {
	_flags () {
		PRINT "-------------|------|---------------------|"
		PRINT "Flag|Args|Description"
		PRINT "-------------|------|---------------------|"
		PRINT "|||"
		PRINT "-h, --help|n/a|Show this prompt"
	}

	PRINT "script - description"
	PRINT
	PRINT "Usage:\t\tscript <flag> <args?>"
	PRINT "Example:\tscript --help"
	PRINT
	_flags | column -t -s'|'
}

while test $# -gt 0; do

	case $(LOWERCASE ${1}) in

		\? | -h | --help ) shift; _help; exit 0 ;;

		* ) [[ -z "${1}" ]] && _help && exit 0; PRINT "script: Invalid argument '${1}'" ;;

	esac

done

