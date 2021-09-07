#!/bin/zsh

# ZSH folder
export zfiles=${HOME}/.zsh
export zsettings=( ${zfiles}/settings/* )
export zplugins="${zfiles}/plugins"
export zsources=( ${zfiles}/sources/* )

# File Lists
files=()

[[ ${#zsources[@]} -gt 0 ]] && files+=( ${zsources[@]} )
[[ ${#zsettings[@]} -gt 0 ]] && files+=( ${zsettings[@]} )

# Load all files
for file in ${files[@]}
do
	. "${file}"
done

# Plugin Loading (see $zfiles/settings/01-zsh.zsh)
for plugin in ${plugins[@]}; do

	plugPath="${zplugins}/${plugin}.zsh"

	if [[ -f "${plugPath}" ]]
	then
		. "${plugPath}"
	else
		echo "zshrc: Plugin '${plugin}' not valid. Please edit '${HOME}/.zsh/settings/01-zsh.zsh'."
	fi

done

# Header 
# motd || fetcher || neofetch || printf "%b" ""
# neofetch || fetcher || motd || printf "%b" ""
# fetcher || neofetch || motd || printf "%b" ""
motd

function precmd()
{
	for ((i = 0; i < $COLUMNS; ++i)); do
	  printf -
	done

	printf "%b\n" ""
}

# Prompt
export PS1='C:$(pwd | tr "////" "\\\\" ) > '
export RPS1='$HOSTNAME'
