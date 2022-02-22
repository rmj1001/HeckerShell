#!/usr/bin/env bash

##############################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: Flatpak install helper
#   Version: 1.0
#
#   Usage: flatconfig.sh
#
#   Description:
#		Install flatpak repositories and software
##############################################

flatpak remote-add --if-not-exists --user \
	flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak remote-add --if-not-exists --user \
	elementaryio https://flatpak.elementary.io/repo.flatpakrepo

flatpak repair --user

flatpak install --user --noninteractive --or-update flathub \
	ar.xjuan.Cambalache \
	ca.desrt.dconf-editor \
	com.axosoft.GitKraken \
	com.belmoussaoui.Authenticator \
	com.belmoussaoui.Obfuscate \
	com.bitstower.Markets \
	com.bitwarden.desktop \
	com.discordapp.Discord \
	com.etlegacy.ETLegacy \
	com.github.bleakgrey.tootle \
	com.github.calo001.fondo \
	com.github.hugolabe.Wike \
	com.github.maoschanz.drawing \
	com.github.rafostar.Clapper \
	com.github.tchx84.Flatseal \
	com.github.wwmm.easyeffects \
	com.gitlab.newsflash \
	com.mattjakeman.ExtensionManager \
	com.obsproject.Studio \
	com.rafaelmardojai.Blanket \
	com.skype.Client \
	com.thebrokenrail.MCPIReborn \
	com.usebottles.bottles \
	com.vscodium.codium \
	de.haeckerfelix.Fragments \
	de.haeckerfelix.Shortwave \
	dev.geopjr.Hashbrown \
	fr.romainvigier.MetadataCleaner \
	im.bernard.Nostalgia \
	io.github.Soundux \
	io.github.achetagames.epic_asset_manager \
	io.github.prateekmedia.appimagepool \
	io.github.seadve.Kooha \
	io.github.shiftey.Desktop \
	it.mijorus.smile \
	net.veloren.veloren \
	network.loki.Session \
	nl.hjdskes.gcolor3 \
	org.audacityteam.Audacity \
	org.freedesktop.Sdk \
	org.freedesktop.Sdk.Extension.dotnet \
	org.freedesktop.Sdk.Extension.golang \
	org.freedesktop.Sdk.Extension.haskell \
	org.freedesktop.Sdk.Extension.mono6 \
	org.freedesktop.Sdk.Extension.node16 \
	org.freedesktop.Sdk.Extension.openjdk \
	org.freedesktop.Sdk.Extension.php74 \
	org.freedesktop.Sdk.Extension.rust-stable \
	org.gabmus.giara \
	org.gimp.GIMP \
	org.gimp.GIMP.Manual \
	org.gimp.GIMP.Plugin.Resynthesizer \
	org.gnome.Aisleriot \
	org.gnome.Boxes \
	org.gnome.Builder \
	org.gnome.Calculator \
	org.gnome.Calls \
	org.gnome.Chess \
	org.gnome.Connections \
	org.gnome.DejaDup \
	org.gnome.Evince \
	org.gnome.Extensions \
	org.gnome.Fractal \
	org.gnome.Lollypop \
	org.gnome.Maps \
	org.gnome.Mines \
	org.gnome.PasswordSafe \
	org.gnome.Podcasts \
	org.gnome.Polari \
	org.gnome.Sdk \
	org.gnome.Sdk \
	org.gnome.TextEditor \
	org.gnome.World.PikaBackup \
	org.gnome.design.IconLibrary \
	org.gnome.eog \
	org.gnome.gitlab.Cowsay \
	org.gnome.gitlab.YaLTeR.VideoTrimmer \
	org.gnome.gitlab.somas.Apostrophe \
	org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive \
	org.gnome.seahorse.Application \
	org.gnucash.GnuCash \
	org.gustavoperedo.FontDownloader \
	org.inkscape.Inkscape \
	org.kde.kdenlive \
	org.kde.krita \
	org.libreoffice.LibreOffice \
	org.mozilla.firefox \
	org.onlyoffice.desktopeditors \
	org.signal.Signal \
	org.turbowarp.TurboWarp \
	org.videolan.VLC \
	org.x.Warpinator \
	org.xonotic.Xonotic \
	re.sonny.Commit \
	re.sonny.Junction \
	re.sonny.Tangram \
	uk.co.ibboard.cawbird \
	us.zoom.Zoom
