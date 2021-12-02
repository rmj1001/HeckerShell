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

if [[ $EUID -eq 0 ]]; then

	PROGRAM_NAME="$(basename "$0")"

	printf '%b' "'${PROGRAM_NAME}' should not be run as root. "
	printf '%b\n' "Please try again as a normal user."
	exit 1
fi

[[ -x "$(which dnf)" ]] || exit 1

####################################

_repos() {
	# RPM Fusion
	sudo dnf install \
		"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
		"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

	sudo dnf groupupdate core

	# Flatpak Repositories (user-level only)
	flatpak remote-add --user --if-not-exists \
		flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --user --if-not-exists \
		appcenter https://flatpak.elementary.io/repo.flatpakrepo
}

_software() {
	# Development
	sudo dnf update
	sudo dnf groupinstall "Development Tools" "Development Libraries"

	# Homebrew
	bash -c "$(
		curl -fsSL
		https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
	)"

	# Gaming
	sudo dnf install lutris

	# Multimedia codecs & libdvdcss
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" \
		--exclude=PackageKit-gstreamer-plugin

	sudo dnf groupupdate sound-and-video
	sudo dnf install rpmfusion-free-release-tainted
	sudo dnf install libdvdcss

	# Snaps
	sudo dnf install snapd fuse squashfuse kernel-modules
	sudo ln -s /var/lib/snapd/snap /snap

	# Miscellaneous RPMs
	sudo dnf install xclip cronie

	# Zap Appimage PM
	curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh |
		bash -s

	zap init
	zap daemon --install

	# Common flatpaks
	flatpak install --user --noninteractive --or-update flathub \
		com.axosoft.GitKraken \
		com.belmoussaoui.Authenticator \
		com.belmoussaoui.Obfuscate \
		com.discordapp.Discord \
		com.etlegacy.ETLegacy \
		com.github.bleakgrey.tootle \
		com.github.hugolabe.Wike \
		com.github.maoschanz.drawing \
		com.github.rafostar.Clapper \
		com.github.tchx84.Flatseal \
		com.github.wwmm.easyeffects \
		com.valvesoftware.Steam \
		de.haeckerfelix.Fragments \
		io.gdevs.GDLauncher \
		io.github.achetagames.epic_asset_manager \
		io.github.seadve.Kooha \
		io.github.shiftey.Desktop \
		io.mrarm.mcpelauncher \
		net.veloren.veloren \
		network.loki.Session \
		nl.hjdskes.gcolor3 \
		org.freedesktop.LinuxAudio.Plugins.LSP \
		org.freedesktop.LinuxAudio.Plugins.TAP \
		org.freedesktop.LinuxAudio.Plugins.ZamPlugins \
		org.freedesktop.LinuxAudio.Plugins.swh \
		org.freedesktop.Platform.Compat.i386 \
		org.freedesktop.Platform.GL.default \
		org.freedesktop.Platform.GL.default \
		org.freedesktop.Platform.GL32.default \
		org.freedesktop.Platform.VAAPI.Intel \
		org.freedesktop.Platform.VAAPI.Intel \
		org.freedesktop.Platform.VAAPI.Intel.i386 \
		org.freedesktop.Platform.ffmpeg-full \
		org.freedesktop.Platform.openh264 \
		org.gimp.GIMP \
		org.gimp.GIMP.Manual \
		org.gnome.Boxes \
		org.gnome.Boxes.Extension.OsinfoDb \
		org.gnome.Builder \
		org.gnome.Connections \
		org.gnome.DejaDup \
		org.gnome.Extensions \
		org.gnome.Lollypop \
		org.gnome.Platform \
		org.gnome.Podcasts \
		org.gnome.Polari \
		org.gnome.TextEditor \
		org.gnome.World.PikaBackup \
		org.gnome.seahorse.Application \
		org.gustavoperedo.FontDownloader \
		org.inkscape.Inkscape \
		org.kde.KStyle.Adwaita \
		org.kde.Platform \
		org.kde.PlatformTheme.QGnomePlatform \
		org.kde.PlatformTheme.QtSNI \
		org.kde.WaylandDecoration.QGnomePlatform-decoration \
		org.kde.kdenlive \
		org.libreoffice.LibreOffice \
		org.mozilla.Thunderbird.Locale \
		org.mozilla.firefox \
		org.onlyoffice.desktopeditors \
		org.signal.Signal \
		org.videolan.VLC \
		org.x.Warpinator \
		re.sonny.Commit \
		re.sonny.Tangram
}

_configs() {
	# DNF

	local configFileContents="fastestmirror=True
	max_parallel_downloads=20
	deltrarpm=True
	defaultyes=True"

	printf '%b\n' "${configFileContents}"

	# Enable cronie
	systemctl enable crond
}

_repos
_software
_configs

printf '%b' "Reboot? (Y/n) " && read -r reboot
[[ -z "${reboot}" || "${reboot}" =~ ^[yY][eE]?[sS]?$ ]] && systemctl reboot
