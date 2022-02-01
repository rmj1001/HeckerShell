#!/bin/bash

shell.load() {
	clear

	# shellcheck disable=SC1091 # Source global definitions
	[[ -f /etc/bashrc ]] && source /etc/bashrc

	# Uncomment the following line if you don't like systemctl's auto-paging feature:
	# export SYSTEMD_PAGER=""

	# Source shellrc (common settings between bash and zsh)
	export SHELLFILES="${HOME}/.shellfiles"

	# Source shellrc (common settings between bash and zsh)
	for config in "${SHELLFILES}"/*.sh; do

		# shellcheck disable=SC1090
		source "${config}"

	done

	# Source changable bash settings
	# shellcheck disable=1091
	source "${SHELLFILES}/configs/bash.sh"

	# Load plugins described in ${plugins} array.
	# shellcheck disable=SC2154
	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}"

		# shellcheck disable=SC1090
		[[ -f "${plugin}" ]] && source "${plugin}"
		[[ ! -f "${plugin}" ]] && PRINT "bash: Plugin '${plug}' does not exist."

	done

	motd
}

shell.load
