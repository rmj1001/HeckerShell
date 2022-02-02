# RMCJ's Dotfiles

## Table of Contents

- [RMCJ's Dotfiles](#rmcjs-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [External Places](#external-places)
  - [Warranty](#warranty)
  - [Dotfiles Management](#dotfiles-management)
    - [**Install**](#install)
    - [**Uninstall**](#uninstall)
    - [**Update**](#update)
  
## External Places

- [Dev Guidelines](docs/dev-rules.md)
- [Script Tricks](docs/script-tricks.md)
- [Distro Postinstallation Handlers](files/Postinstallers)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.
All scripts are licensed under the BSD 3 Clause license.

## Dotfiles Management

You can either manage dotfiles manually via cloning, or you can use the
scripts provided here to manage them. **WARNING:** Downloading scripts from
the internet and running them is dangerous, make sure to audit these before
running them.

You can also use the built-in `dotfiles` script to update, clean update (uninstall/install),
or uninstall the dotfiles from within your terminal. More management functionality
may come to this script in the future. Use `dotfiles ?` to get started.

Note: The installer **WILL** replace your `.bashrc`, `.zshrc`, and possibly
other config files with symlinks. Make sure to back them up.

### **Install**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto/install.sh)
```

### **Uninstall**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto/uninstall.sh)
```

### **Update**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto/update.sh)
```
