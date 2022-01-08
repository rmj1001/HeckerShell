# Post-installation Scripts

The scripts in this directory install common software, repositories, and apply
common configurations for various OSs.

- [Post-installation Scripts](#post-installation-scripts)
  - [Distro Installers](#distro-installers)
  - [Flatpak Apps Installer](#flatpak-apps-installer)
  - [Portable Apps Installer](#portable-apps-installer)

## Distro Installers

__Fedora:__

```bash
# curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/fedora.sh)"
```

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/fedora.sh)"
```

__Ubuntu:__

```bash
# curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/ubuntu.sh)" 
```

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/ubuntu.sh)" 
```

## Flatpak Apps Installer

```bash
# curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/helpers/flatconfig.sh)"
```

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/helpers/flatconfig.sh)"
```

## Portable Apps Installer

```bash
# curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/helpers/portableApps.sh)"
```

```bash
# wget
bash -c "$(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/files/System32/postinstalls/helpers/portableApps.sh)"
```