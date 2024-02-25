#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

# TODO: Finish Scripts/shellmgr and remove 01-dotfilesmgr.sh

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

# export PS1='\n$(shell lines)\n$(printf "%${COLUMNS}s\n" "$(date -u +"%m-%d-%Y %H:%M:%S")")[ ${USER}@${HOSTNAME} $(basename $(dirs +0)) ]$ '
export PS1='\n$(TITLE "${SHELL_TITLE}")$(shell lines)\n$(printf "%${COLUMNS}s\n" "${PWD}")[ ${USER}@${HOSTNAME} "$(basename "$(dirs +0)")" ]$ '

# Run the plugin loader
"${SHELLFILES}"/00-plugin-loader.sh

shell fresh-screen
TITLE "HeckerShell"
