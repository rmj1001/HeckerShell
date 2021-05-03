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

	. "${zplugins}/${plugin}.zsh"

done

# Header
motd || fetcher || neofetch || printf "%b" ""

function precmd()
{
	for ((i = 0; i < $COLUMNS; ++i)); do
	  printf -
	done

	printf "%b\n" ""
}

# Prompt
export PS1='C:$(pwd | tr "////" "\\\\" ) > '
