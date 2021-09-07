#!/bin/zsh

# File Lists
files=()

# ZSH folder
export zfiles=${HOME}/.zsh
export zplugins="${HOME}/.zsh/plugins"
export zsettings=( ${HOME}/.zsh/settings/* ); [[ ${#zsettings[@]} -gt 0 ]] && files+=( ${zsettings[@]} )
export zsources=( ${HOME}/.zsh/sources/* ); [[ ${#zsources[@]} -gt 0 ]] && files+=( ${zsources[@]} )

# Load all files
for file in ${files[@]}
do
	. "${file}"
done

# Remove 'files' array
unset files

# Plugin Loading (Enable in '$HOME/.zsh/settings/01-zsh.zsh')
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
