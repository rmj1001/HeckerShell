###############################
#
#   Flatpak Configuration Script
# 
###############################

flatpak remote-add --if-not-exists --user \
	flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak remote-add --if-not-exists --user \
	elementaryio https://flatpak.elementary.io/repo.flatpakrepo

flatpak repair --user

flatpak install --user --noninteractive --or-update flathub \
ar.xjuan.Cambalache \
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
com.gitlab.newsflash \
com.thebrokenrail.MCPIReborn \
com.usebottles.bottles \
com.valvesoftware.Steam \
de.haeckerfelix.Fragments \
de.haeckerfelix.Shortwave \
dev.geopjr.Hashbrown \
fr.romainvigier.MetadataCleaner \
io.github.Soundux \
io.github.achetagames.epic_asset_manager \
io.github.prateekmedia.appimagepool \
io.github.seadve.Kooha \
io.github.shiftey.Desktop \
io.mrarm.mcpelauncher \
net.veloren.veloren \
network.loki.Session \
nl.hjdskes.gcolor3 \
org.gimp.GIMP \
org.gimp.GIMP.Manual \
org.gnome.Boxes \
org.gnome.Boxes.Extension.OsinfoDb \
org.gnome.Builder \
org.gnome.Calculator \
org.gnome.Chess \
org.gnome.Connections \
org.gnome.DejaDup \
org.gnome.Evince \
org.gnome.Extensions \
org.gnome.Lollypop \
org.gnome.Maps \
org.gnome.Mines \
org.gnome.Podcasts \
org.gnome.Polari \
org.gnome.Sdk \
org.gnome.TextEditor \
org.gnome.World.PikaBackup \
org.gnome.design.IconLibrary \
org.gnome.eog \
org.gnome.gitlab.YaLTeR.VideoTrimmer \
org.gnome.gitlab.somas.Apostrophe \
org.gnome.gitlab.somas.Apostrophe \
org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive \
org.gnome.seahorse.Application \
org.gnucash.GnuCash \
org.gnucash.GnuCash.Locale \
org.gustavoperedo.FontDownloader \
org.inkscape.Inkscape \
org.kde.kdenlive \
org.libreoffice.LibreOffice \
org.mozilla.Thunderbird.Locale \
org.mozilla.firefox \
org.onlyoffice.desktopeditors \
org.signal.Signal \
org.videolan.VLC \
org.x.Warpinator \
org.xonotic.Xonotic \
re.sonny.Commit \
re.sonny.Junction \
re.sonny.Tangram \
uk.co.ibboard.cawbird \
us.zoom.Zoom
