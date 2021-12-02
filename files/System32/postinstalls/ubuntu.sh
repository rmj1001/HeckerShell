#!/usr/bin/env bash

##############################################
#   Author: Roy Conn
#   Project: Ubuntu postinstall
#   Version: 1.0
#
#   Usage: ubuntu.sh
#
#   Description:
#		Curlable ubuntu post-install script
##############################################

if [[ $EUID -eq 0 ]]; then

	PROGRAM_NAME="$(basename "$0")"

	printf '%b' "'${PROGRAM_NAME}' should not be run as root. "
	printf '%b\n' "Please try again as a normal user."
	exit 1
fi

[[ -x "$(which apt)" ]] || (
	printf '%b\n' "This script must be run on Ubuntu." && exit 1
)

################################################################################
# REPOSITORY SETUP
#

# Install repositories/ppas
ppas=(
	"ppa:lutris-team/lutris"
	"multiverse"
)

for ppa in "${ppas[@]}"; do

	sudo add-apt-repository -y -n "${ppa}"

done

sudo apt update

# Flatpak Install
sudo apt install flatpak gnome-software-plugin-flatpak

# Flatpak Repositories (user-level only)
flatpak remote-add --user --if-not-exists \
	flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists \
	appcenter https://flatpak.elementary.io/repo.flatpakrepo

################################################################################
# SOFTWARE INSTALLATION
#

# Install common packages
sudo apt install \
	lutris \
	steam-installer \
	build-essential \
	meson \
	libsystemd-dev \
	pkg-config \
	ninja-build \
	git \
	libdbus-1-dev \
	libinih-dev \
	ubuntu-restricted-extras

# Zap Appimage PM
curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh |
	bash -s

zap init
zap daemon --install

# Homebrew
bash -c "$(
	curl -fsSL
	https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
)"

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

################################################################################
# REBOOT
#

printf '%b' "Reboot? (Y/n) " && read -r reboot
[[ -z "${reboot}" || "${reboot}" =~ ^[yY][eE]?[sS]?$ ]] && systemctl reboot
