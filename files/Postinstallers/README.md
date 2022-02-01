# Post-installation Scripts

The scripts in this directory install common software, repositories, and apply
common configurations for various OSs.

Return [Home](../../README.md)

__Table of Contents:__

- [Post-installation Scripts](#post-installation-scripts)
  - [Distro Installers](#distro-installers)
  - [Flatpak Apps Installer](#flatpak-apps-installer)
  - [Portable Apps Installer](#portable-apps-installer)

## Distro Installers

__Fedora:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/Postinstallers/fedora.sh)"
```

__Ubuntu:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/Postinstallers/ubuntu.sh)" 
```

## Flatpak Apps Installer

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/Postinstallers/helpers/flatconfig.sh)"
```

## Portable Apps Installer

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/Postinstallers/helpers/portableApps.sh)"
```
