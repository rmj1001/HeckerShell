#!/bin/zsh

# File Lists
files=()

# ZSH folder
export zshrc="${HOME}/.zshrc"
export zfiles="${HOME}/.zsh"
export zPluginsPath="${zfiles}/plugins"
export zSettingsPath="${zfiles}/settings"
export zSourcesPath="${zfiles}/sources"
export zsettings=( ${zSettingsPath}/* ); [[ ${#zsettings[@]} -gt 0 ]] && files+=( ${zsettings[@]} )
export zsources=( ${zSourcesPath}/* ); [[ ${#zsources[@]} -gt 0 ]] && files+=( ${zsources[@]} )

# Load all files
for file in ${files[@]}
do
	. "${file}"
done

# Remove 'files' array
unset files

# Plugin Loading (Enable in '$HOME/.zsh/settings/01-zsh.zsh')
for plugin in ${plugins[@]}; do

	plugPath="${zPluginsPath}/${plugin}.zsh"

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
