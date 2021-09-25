#!/bin/zsh

# ZSH folder
export zshrc="${HOME}/.zshrc"
export zfiles="${HOME}/.zsh"
export zPluginsPath="${zfiles}/plugins"
export zSettingsPath="${zfiles}/settings"
export zSourcesPath="${zfiles}/sources"

### Settings Loading
# usage: zsh.load_settings
zsh.load_settings()
{
	for file in ${zSettingsPath}/*
	do
		. "${file}"
	done
}

### Sources Loading
# usage: zsh.load_sources
zsh.load_sources()
{
	for file in ${zSourcesPath}/*
	do
		. "${file}"
	done
}

### Plugin Loading (Enable in '$HOME/.zsh/settings/01-zsh.zsh')
# usage: zsh.load_plugins
zsh.load_plugins()
{
	for plugin in ${plugins[@]}; do

		plugPath="${zPluginsPath}/${plugin}.zsh"

		if [[ -f "${plugPath}" ]]
		then
			. "${plugPath}"
		else
			echo "zshrc: Plugin '${plugin}' not valid. Please edit '${HOME}/.zsh/settings/01-zsh.zsh'."
		fi

	done
}

### Message of the Day
# usage: motd
zsh.motd ()
{
    local motdFile="${zfiles}/.motd.txt"

    [[ -f "${motdFile}" ]] || return 0

    [[ "$1" == '--lolcat' ]] && SILENTRUN command -v lolcat && lolcat ${motdFile} && return 0
    [[ "$1" == '--edit' ]] && ${EDITOR} ${motdFile} && return 0

    cat ${motdFile}
}

# Load everything
zsh.load_settings
zsh.load_sources
zsh.load_plugins
zsh.motd

function precmd()
{
	for ((i = 0; i < $COLUMNS; ++i)); do
	printf -
	done

	printf "%b\n" ""
}
