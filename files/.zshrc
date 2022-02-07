#!/bin/zsh

shell.load() {
	clear

	export SHELLFILES="${HOME}/.shellfiles"

	# Source shellrc (common settings between bash and zsh)
	for config in ${SHELLFILES}/*.sh; do
		source "${config}"
	done

	# Source changable zsh settings
	source "${SHELLFILES}/configs/zsh.sh"

	# Load plugins described in ${plugins} array.
	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}.sh"

		[[ -f "${plugin}" ]] && source ${plugin} || PRINT "zsh: Plugin '${plug}' does not exist."

	done

	freshscreen --no-clear

	function precmd() {
		for ((i = 0; i < $COLUMNS; ++i)); do
			printf -
		done

		printf "%b\n" ""
	}
}

shell.load
