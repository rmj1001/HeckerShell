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

##############################################
# PRE-PROCESSING

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

DISABLE_ROOT || exit 1
REQUIRE_CMD "" || exit 1

##############################################
# HELP MENU BUILDER

SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="description"
SCRIPT_USAGE="[FLAGS] [ARGS?] ..."

# Examples
EXAMPLE "--help" "Shows the help prompt"

# Flags
FLAG "-f, --flag" "<arg>" "Description"
FLAG "" "" "" # Leave all spaces empty to give space between groups of flags

##############################################
# MAIN LOGIC

# If no arguments are give, just show help prompt.
[[ $# -eq 0 ]] && HELP && exit 0

# Iterate over all arguments and evaluate them
while [[ $# -gt 0 ]]; do

	case "$(LOWERCASE "${1}")" in

	\? | -h | --help)
		shift
		HELP
		exit 0
		;;

	*) INVALID_CMD "${1}" && exit 1 ;;

	esac

done
