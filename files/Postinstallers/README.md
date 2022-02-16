<!--
##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Distro post-install info
#
##############################################
-->
# Post-installation Scripts

The scripts in this directory install common software, repositories, and apply
common configurations for various OSs.

Return [Home](../../README.md)

__Table of Contents:__

- [Post-installation Scripts](#post-installation-scripts)
  - [Distro Installers](#distro-installers)
  - [Miscellaneous Installers](#miscellaneous-installers)

## Distro Installers

__Fedora:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/files/Postinstallers/fedora.sh)"
```

__Ubuntu:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/files/Postinstallers/ubuntu.sh)" 
```

## Miscellaneous Installers

__Flatpak Apps:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/files/Postinstallers/helpers/flatconfig.sh)"
```

__Portable Apps:__

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/files/Postinstallers/helpers/portableApps.sh)"
```
