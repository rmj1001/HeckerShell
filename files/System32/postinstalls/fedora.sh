#!/usr/bin/env bash

##############################################
#   Author: Roy Conn
#   Project: Fedora postinstall
#   Version: 1.0
#
#   Usage: fedora.sh
#
#   Description:
#		Curlable fedora post-install script
##############################################

if [[ $EUID -eq 0 ]]; then

	PROGRAM_NAME="$(basename "$0")"

	printf '%b' "'${PROGRAM_NAME}' should not be run as root. "
	printf '%b\n' "Please try again as a normal user."
	exit 1
fi

[[ -x "$(which dnf)" ]] || (
	printf '%b\n' "This script must be run on Fedora." && exit 1
)

################################################################################
# REPOSITORY SETUP
#

clear

# Configure DNF
configFileContents="fastestmirror=True
max_parallel_downloads=20
deltrarpm=True
defaultyes=True"

printf '%b\n' "${configFileContents}" | sudo tee /etc/dnf/dnf.conf

# RPM Fusion
sudo dnf install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo dnf groupupdate core

################################################################################
# SOFTWARE INSTALLATION
#

# Development
sudo dnf update
sudo dnf groupinstall "Development Tools" "Development Libraries"

# Multimedia codecs & libdvdcss
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" \
	--exclude=PackageKit-gstreamer-plugin

sudo dnf groupupdate sound-and-video
sudo dnf install rpmfusion-free-release-tainted
sudo dnf install libdvdcss

# Gaming
sudo dnf install lutris

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

# Homebrew
bash -c "$(
	curl -fsSL
	https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
)"

# Install flatpaks


################################################################################
# MISCELLANEOUS CONFIGS
#

# Enable cronie
systemctl enable crond

################################################################################
# REBOOT
#

printf '%b' "Reboot? (Y/n) " && read -r reboot
[[ -z "${reboot}" || "${reboot}" =~ ^[yY][eE]?[sS]?$ ]] && systemctl reboot
