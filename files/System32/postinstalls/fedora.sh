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
REQUIRE_CMD "dnf" || exit 1

####################################

REBOOT=0

_help ()
{
	_flags ()
	{
		PRINT "-------------|------|---------------------|"
		PRINT "Flag|Args|Description"
		PRINT "-------------|------|---------------------|"
		PRINT "|||"
		PRINT "-r, --repos|n/a|Install common repositories"
		PRINT "-s, --software|n/a|Install common software"
		PRINT "-c, --config|n/a|Apply common configurations"
		PRINT "-a, --all|n/a|Do all the things"
		PRINT "--reboot|n/a|Reboot the computer after installation"
		PRINT "|||"
		PRINT "-h, --help|n/a|Show this prompt"
	}

	PRINT "$(SCRIPTNAME) - Install common fedora software"
	PRINT "Note: it's recommended to install repositories, software, and configs in that order."
	PRINT
	PRINT "Usage:\t\t$(SCRIPTNAME) <flag> <args?>"
	PRINT "Example:\t$(SCRIPTNAME) --help"
	PRINT
	_flags | column -t -s'|'
}

_repos ()
{
	# RPM Fusion
	sudo dnf install \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	sudo dnf groupupdate core

	# Flathub
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

_software ()
{
	# Development
	sudo dnf update
	sudo dnf groupinstall "Development Tools" "Development Libraries"

	# Homebrew
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Gaming
	sudo dnf install lutris

	# Multimedia codecs & libdvdcss
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate sound-and-video
	sudo dnf install rpmfusion-free-release-tainted
	sudo dnf install libdvdcss

	# Snaps
	sudo dnf install snapd fuse squashfuse kernel-modules
	sudo ln -s /var/lib/snapd/snap /snap

	# Miscellaneous RPMs
	sudo dnf install xclip cronie

	# Zap Appimage PM
	curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | bash -s
	zap init
	zap daemon --install

	# Common flatpaks
	flatpak install --user --noninteractive --or-update flathub \
		org.cvfosammmm.Setzer \
		org.gnome.seahorse.Application \
		io.gdevs.GDLauncher \
		org.gnome.TextEditor \
		org.gnome.Polari \
		org.gnome.Podcasts \
		org.gnome.DejaDup \
		org.gnome.Builder \
		org.gnome.Extensions \
		io.github.seadve.Kooha \
		com.github.maoschanz.drawing \
		com.github.bleakgrey.tootle \
		de.haeckerfelix.Fragments \
		org.gimp.GIMP \
		org.inkscape.Inkscape \
		org.libreoffice.LibreOffice \
		com.valvesoftware.Steam \
		com.discordapp.Discord \
		org.videolan.VLC \
		org.videolan.VLC.Plugin.makemkv \
		org.videolan.VLC.Plugin.fdkaac
}

_configs ()
{
	# DNF
	PRINT "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
	PRINT "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
	PRINT "deltarpm=True" | sudo tee -a /etc/dnf/dnf.conf
	PRINT "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

	# Enable cronie
	systemctl enable crond
}

_all ()
{
	_repos; _development; _games; _media; _snapd; _configs
}

# If no arguments are give, just show help prompt.
[[ $# -eq 0 ]] && _help && exit 0

# Iterate over all arguments and evaluate them
while test $# -gt 0; do

	case "$(LOWERCASE ${1})" in

		-r | --repos ) shift; _repos ;;
		-s | --software ) shift; _software ;;
		-c | --config ) shift; _configs ;;
		-a | --all ) shift; _all; exit ;;
		--reboot ) REBOOT=1 ;;

		\? | -h | --help ) shift; _help; exit 0 ;;

		* ) PRINT "$(SCRIPTNAME): Invalid argument '${1}'" && exit 1 ;;

	esac

done

[[ ${REBOOT} -eq 1 ]] && sudo reboot

