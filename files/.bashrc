#!/bin/bash

bash.load() {
	clear

	# shellcheck disable=SC1091 # Source global definitions
	[[ -f /etc/bashrc ]] && source /etc/bashrc

	# Uncomment the following line if you don't like systemctl's auto-paging feature:
	# export SYSTEMD_PAGER=

	# Source shellrc (common settings between bash and zsh)
	export SHELLFILES="${HOME}/.shellfiles"

	# shellcheck disable=SC1091
	source "${SHELLFILES}/.shellenv"
	# shellcheck disable=SC1091
	source "${SHELLFILES}/.shellfns"
	# shellcheck disable=SC1091
	source "${SHELLFILES}/.shellsrcs"

	export PS1='\n$(write_lines)\n$(printf "%${COLUMNS}s\n" "$(date -u +"%m-%d-%Y %H:%M:%S")")[ ${USER}@${HOSTNAME} ] $(pwd) > '

	# Plugins
	export plugins=(
		backstreet
		curlapps
	)

	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}"

		# shellcheck disable=SC1090
		[[ -f "${plugin}" ]] && source "${plugin}"
		[[ ! -f "${plugin}" ]] && PRINT "zsh: Plugin '${plug}' does not exist."

	done

	motd
}

bash.load
