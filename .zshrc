#!/bin/zsh

# ZSH folder
export zfiles=${HOME}/.zsh
export zsettings=( ${zfiles}/settings/* )
export zplugins=( ${zfiles}/plugins/* )
export zsources=( ${zfiles}/sources/* )

# File Lists
files=()

[[ ${#zsources[@]} -gt 0 ]] && files+=( ${zsources[@]} )
[[ ${#zsettings[@]} -gt 0 ]] && files+=( ${zsettings[@]} )
[[ ${#zplugins[@]} -gt 0 ]] && files+=( ${zplugins[@]} )

# Load all files
for file in ${files[@]}
do
	. "${file}"
done

# Header
motd

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

