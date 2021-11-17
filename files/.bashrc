#!/bin/bash

bash.load()
{
	clear

	# Source global definitions
	[[ -f /etc/bashrc ]] && source /etc/bashrc

	# Uncomment the following line if you don't like systemctl's auto-paging feature:
	# export SYSTEMD_PAGER=

	# Source shellrc (common settings between bash and zsh)
	SHELLFILES="${HOME}/.shellfiles"
	source ${SHELLFILES}/.shellrc

	export PS1='\n$(write_lines)\n$(printf "%${COLUMNS}s\n" "$(date -u +"%m-%d-%Y %H:%M:%S")")[ ${USER}@${HOSTNAME} ] $(pwd) > '

	# Plugins
	export plugins=(
		backstreet
		curlapps
	)

	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}"

		[[ -f "${plugin}" ]] && source ${plugin} || PRINT "zsh: Plugin '${plug}' does not exist."

	done

	# Print MOTD
	cat ${SHELLFILES}/.motd.txt
}

bash.load

