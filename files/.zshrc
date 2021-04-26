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
motd

# Prompt
export PS1="C:%/ > "

