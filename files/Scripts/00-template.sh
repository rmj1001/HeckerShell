#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

##############################################
# PRE-PROCESSING

# shellcheck disable=SC1091
[[ -f "./00-api.sh" ]] || source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh
source ./00-api.sh

DISABLE_ROOT || exit 1

##############################################
# HELP MENU BUILDER

VERSION "1.0"
DESCRIPTION "Insert description here"
USAGE "[FLAG] [ARGS]? ..."

# Examples
EXAMPLE "--flag arg1 arg2" "Description of example command"

# Flags
FLAG "-t" "[arg]" "example flag description"
FLAG "-r" "" "example flag description 2"
FLAG "-c, --complete" "" "example flag description 3"

##############################################
# MAIN LOGIC

### Variables ###
ARGS=("$@")

[[ $# -eq 0 ]] && {
  HELP
  exit 0
}

### Flags ###
for ((i = 0; i < ${#ARGS[@]}; i++)); do
  arg="${ARGS[i]}"

  case "$(LOWERCASE "$arg")" in
  \? | -h | --help)
    HELP
    unset 'ARGS[i]'
    exit 0
    ;;
  esac
done

################################################################################
# CODE LOGIC
################################################################################

exit 0
