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
		PRINT "-------------|------|---------------------|"
		PRINT "Flag|Args|Description"
		PRINT "-------------|------|---------------------|"
		PRINT "|||"
		PRINT "-r, --repos|n/a|Install common repositories"
		PRINT "-d, --development|n/a|Install developer libraries"
		PRINT "-g, --games|n/a|Install games/supporting software"
		PRINT "-m, --media|n/a|Install media codecs"
		PRINT "-s, --snapd|n/a|Install snapd"
		PRINT "-a, --all|n/a|Install all software"
		PRINT "--reboot|n/a|Reboot the computer after installation"
		PRINT "|||"
		PRINT "-h, --help|n/a|Show this prompt"
	}

	PRINT "$(SCRIPTNAME) - Install common fedora software after install"
	PRINT
	PRINT "Usage:\t\t$(SCRIPTNAME) <flag> <args?>"
	PRINT "Example:\t$(SCRIPTNAME) --help"
	PRINT
	_flags | column -t -s'|'
}

_repos () {
	# RPM Fusion
	sudo dnf install \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	sudo dnf groupupdate core

	# Flathub
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

_development () {
	sudo dnf update
	sudo dnf groupinstall "Development Tools" "Development Libraries"

}

_games () {
	sudo dnf install lutris
	flatpak install flathub io.gdevs.GDLauncher
}

_media () {
	# Install multimedia codecs
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate sound-and-video

	# Install libdvdcss
	sudo dnf install rpmfusion-free-release-tainted
	sudo dnf install libdvdcss
}

_snapd () {
	sudo dnf install snapd fuse squashfuse kernel-modules
	sudo ln -s /var/lib/snapd/snap /snap
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
		-s | --snapd ) shift; _snapd ;;
		-a | --all ) shift; _repos; _development; _games; _media; _snapd ;;
		--reboot ) REBOOT=1 ;;

		\? | -h | --help ) shift; _help; exit 0 ;;

		* ) PRINT "$(SCRIPTNAME): Invalid argument '${1}'" && exit 1 ;;

	esac

done

[[ ${REBOOT} -eq 1 ]] && sudo reboot
