# RMCJ's Dotfiles
  
## About

These dotfiles have been in development for a couple years now.
It originally began as some personal settings built on top of
oh-my-zsh's existing framework, but it has since grown out of that.
I have completely replaced oh-my-zsh's files and settings with my own,
thus eliminating much unneeded bloat. All plugins, shell themes, scripts,
and configs are custom developed to suit my workflow, and all loading
logic for these configs are handled by a top-level config for each shell.

Both ZSH and Bash can use most of these settings; however, each shell has
a reloadable config for those settings that cannot be used for both.

## Links to parts of this project

- [Distro Post-install Handlers](files/Postinstallers)
- [Scripts](files/System32)
- Developer Docs
  - [Guidelines](docs/dev-rules.md)
  - [Tips & Tricks](docs/script-tricks.md)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.
All code is licensed under the BSD 3 Clause license.

## Dotfiles Management

You can either manage dotfiles manually via cloning, or you can use the
scripts provided here to manage them. **WARNING:** Downloading scripts from
the internet and running them is dangerous, make sure to audit these before
running them.

You can also use the built-in `dotfiles` script to update, clean update (uninstall/install),
or uninstall the dotfiles from within your terminal. More management functionality
may come to this script in the future. Use `dotfiles ?` to get started.

Note: The installer **WILL** replace your `.bashrc`, `.zshrc`, and possibly
other config files with symlinks. Make sure to back them up. If you uninstall
these dotfiles, some configs may be replaced with those provided in `/etc/skel`.

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
