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
bash <(curl -s https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/flatconfig.sh)

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

################################################################################
# REBOOT
#

printf '%b' "Reboot? (Y/n) " && read -r reboot
[[ -z "${reboot}" || "${reboot}" =~ ^[yY][eE]?[sS]?$ ]] && systemctl reboot
