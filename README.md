# RMCJ's Dotfiles

## Table of Contents

- [RMCJ's Dotfiles](#rmcjs-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Warranty](#warranty)
  - [Dotfiles Management](#dotfiles-management)
    - [**Install**](#install)
    - [**Uninstall**](#uninstall)
    - [**Update**](#update)
  - [Distro Postinstall Scripts](#distro-postinstall-scripts)
  - [External Guides](#external-guides)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.

All scripts are licensed under the BSD 3 Clause license.

## Dotfiles Management

You can either manage dotfiles manually via cloning, or you can use the
scripts provided here to manage them. **WARNING:** Downloading scripts from
the internet and running them is dangerous, make sure to audit these before
running them.

Note: The installer **WILL** replace your `.bashrc`, `.zshrc`, and possibly 
other config files with symlinks. Make sure to back them up.

### **Install**

Using `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/install.sh)
```

Using `curl`:

```bash
bash <(curl -s https://raw.githubusercontent.com/rmj1001/dotfiles/main/install.sh)
```

### **Uninstall**

Using `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/uninstall.sh)
```

Using `curl`:

```bash
bash <(curl -s https://raw.githubusercontent.com/rmj1001/dotfiles/main/uninstall.sh)
```

### **Update**

Using `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/update.sh)
```

Using `curl`:

```bash
bash <(curl -s https://raw.githubusercontent.com/rmj1001/dotfiles/main/update.sh)
```

## Distro Postinstall Scripts

There are post-install scripts for various distros in
`files/System32/postinstalls`. These scripts install common repositories and
software for development, gaming, media (codecs), and more. These scripts will
source the api since they need certain common functions.

For the postinstall scripts, go [here](https://github.com/rmj1001/dotfiles/tree/main/files/System32/postinstalls)

## External Guides

- [Dev Guidelines](docs/dev-rules.md)
- [Script Tricks](docs/script-tricks.md)
