#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: .bashrc
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Bash config file
#
##############################################

shell.load() {
	clear

	# shellcheck disable=SC1091 # Source global definitions
	[[ -f /etc/bashrc ]] && source /etc/bashrc

	# Uncomment the following line if you don't like systemctl's auto-paging feature:
	# export SYSTEMD_PAGER=""

	# Source shellrc (common settings between bash and zsh)
	export SHELLFILES="${HOME}/.shellfiles"
	for config in "${SHELLFILES}"/*.sh; do

		# shellcheck disable=SC1090
		source "${config}"

	done

	############################################################################
	# PLACE BASH-SPECIFIC SETTINGS IN HERE.

	# export PS1='\n$(write_lines)\n$(printf "%${COLUMNS}s\n" "$(date -u +"%m-%d-%Y %H:%M:%S")")[ ${USER}@${HOSTNAME} $(basename $(dirs +0)) ]$ '
	export PS1='\n$(write_lines)\n$(printf "%${COLUMNS}s\n" "${PWD}")[ ${USER}@${HOSTNAME} $(basename $(dirs +0)) ]$ '

	# Plugins
	export plugins=(
		backstreet
		curlapps
	)

	############################################################################

	# Load plugins described in ${plugins} array.
	# shellcheck disable=SC2154
	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}.sh"

		# shellcheck disable=SC1090
		[[ -f "${plugin}" ]] && source "${plugin}"
		[[ ! -f "${plugin}" ]] && PRINT "bash: Plugin '${plug}' does not exist."

	done

	freshscreen --no-clear
}

shell.load
