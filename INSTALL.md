# Install Instructions

**WARNING:** Downloading scripts from the internet and running them is
dangerous, make sure to audit these before running them.

**WARNING:** Your current `.bashrc`, `.zshrc`, and other configs will be
replaced with symlinks. Make sure to back them up. If you uninstall HeckerShell,
some configs may be replaced with those provided in `/etc/skel`.

You can use the built-in `heckershell` script to update, clean update
(uninstall/install), or uninstall HeckerShell from within your terminal. More
management functionality may come to this script in the future. Use
`heckershell ?` to get started.

## **Install**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/auto/install.sh)
```

## **Uninstall**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/auto/uninstall.sh)
```

## **Update**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/HeckerShell/main/auto/update.sh) && shell reload
```
