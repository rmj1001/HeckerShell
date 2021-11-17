#!/usr/bin/env zsh

zsh.load()
{
	clear

	SHELLFILES="${HOME}/.shellfiles"

	# Syntax Highlighting
	export SYNTAXHIGH="${SHELLFILES}/.syntaxhighlighting"

	# Install syntax highlighting if the ~/.zsh/.syntaxhighlighting folder is missing
	[[ ! -d ${SYNTAXHIGH} ]] && \
		printf "%b\n" "Installing syntax highlighting...\n" && \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${SYNTAXHIGH} && \
		printf "%b\n" "" && read -s -k "?Press ENTER to continue." && clear

	# Source syntax highlighting
	source ${SYNTAXHIGH}/zsh-syntax-highlighting.zsh

	# Prompt
	#export PS1='C:$(pwd | tr "////" "\\\\" ) > '
	export PS1='[ ${USER}@${HOSTNAME} ] ${PWD} > '
	export RPS1='$(date -u +"%m-%d-%Y %H:%M:%S")'

	# History
	export HISTFILE="${HOME}/.zsh-history"
	export HISTSIZE=1000
	export SAVEHIST=1000

	# ZSH Options
	setopt +o nomatch
	setopt NO_HUP
	setopt AUTO_CD
	setopt AUTO_MENU
	#setopt LIST_ROWS_FIRST
	setopt SHARE_HISTORY
	setopt EXTENDED_HISTORY
	setopt PROMPT_SUBST

	# Ctrl ->
	bindkey ';5C' forward-word

	# Ctrl <-
	bindkey ';5D' backward-word

	zstyle ':completion:*' rehash true
	zstyle ':completion:*' menu select

	fpath=($HOME/.local/share/zsh-completions/src $fpath)
	autoload -U compinit && compinit

	# Source shellrc (common settings between bash and zsh)
	source ${SHELLFILES}/.shellrc

	# Plugins
	export plugins=(
		sudo
		backstreet
		curlapps
	)

	for plug in "${plugins[@]}"; do

		plugin="${SHELLFILES}/plugins/${plug}"

		[[ -f "${plugin}" ]] && source ${plugin} || PRINT "zsh: Plugin '${plug}' does not exist."

	done

	# Print MOTD
	cat ${SHELLFILES}/.motd.txt
	printf "%b\n"

	function precmd()
	{
		for ((i = 0; i < $COLUMNS; ++i)); do
		printf -
		done

		printf "%b\n" ""
	}
}

zsh.load

