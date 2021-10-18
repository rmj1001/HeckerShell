#!/usr/bin/env bash

##############################################
#   Author: Roy Conn
#   Project: Fedora postinstall
#   Version: 1.0
#
#   Usage: fedora.sh <flag> <args[]>...
#
#   Description:
#		Postinstall script for fedora
##############################################

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

# Preprocessing flags
DISABLE_ROOT

####################################

REBOOT=0

_help () {
	_flags () {
		PRINT "----|----|-----------|"
		PRINT "Flag|Args|Description"
		PRINT "----|----|-----------|"
		PRINT "|||"
		PRINT "-r, --repos|n/a|Install common repositories"
		PRINT "-d, --development|n/a|Install developer libraries"
		PRINT "-g, --games|n/a|Install games/supporting software"
		PRINT "-m, --media|n/a|Install media codecs"
		PRINT "-a, --all|n/a|Install all software"
		PRINT "--reboot|n/a|Reboot the computer after installation"
		PRINT "|||"
		PRINT "-h, --help|n/a|Show this prompt"
	}

	PRINT "$(SCRIPTNAME) - Install common ubuntu software after install"
	PRINT
	PRINT "Usage:\t\t$(SCRIPTNAME) <flag> <args?>"
	PRINT "Example:\t$(SCRIPTNAME) --help"
	PRINT
	_flags | column -t -s'|'
}

_repos () {

	# Install repositories/ppas
	ppas=(
		"ppa:lutris-team/lutris"
	)

	for ppa in "${ppas[@]}"; do

		sudo add-apt-repository -y -n "${ppa}"

	done

	# Flathub
	sudo apt update
	sudo apt install flatpak gnome-software-plugin-flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

_development () {
	sudo apt update
	sudo apt install build-essential git
}

_games () {

	# Install common gaming packages
	packages=(
		"lutris"
		"steam-installer"
		"meson"
		"libsystemd-dev"
		"pkg-config"
		"ninja-build"
		"git"
		"libdbus-1-dev"
		"libinih-dev"
	)

	sudo apt install "${packages[@]}"

	# Gamemode
	cd $HOME/Downloads
	[[ -d "$HOME/Downloads/gamemode" ]] || git clone https://github.com/FeralInteractive/gamemode.git
	cd gamemode

	git checkout "${gamemodeVersion}"
	./bootstrap.sh

	# GDlauncher minecraft
	flatpak install flathub io.gdevs.GDLauncher
}

_media () {
	# Install multimedia codecs
	sudo add-apt-repository multiverse
	sudo apt install ubuntu-restricted-extras
}

# If no arguments are give, just show help prompt.
[[ $# -eq 0 ]] && _help && exit 0

# Iterate over all arguments and evaluate them
while test $# -gt 0; do

	case "$(LOWERCASE ${1})" in

		-r | --repos ) shift; _repos ;;
		-d | --development ) shift; _development ;;
		-g | --games ) shift; _games ;;
		-m | --media ) shift; _media ;;
		-a | --all ) shift; _repos; _development; _games; _media ;;
		--reboot ) REBOOT=1 ;;

		\? | -h | --help ) shift; _help; exit 0 ;;

		* ) PRINT "$(SCRIPTNAME): Invalid argument '${1}'" && exit 1 ;;

	esac

done

[[ ${REBOOT} -eq 1 ]] && sudo reboot

