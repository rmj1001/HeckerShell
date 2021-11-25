# RMCJ's Dotfiles

## Table of Contents

- [RMCJ's Dotfiles](#rmcjs-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Warranty](#warranty)
  - [Install](#install)
  - [Distro Postinstall Scripts](#distro-postinstall-scripts)
  - [Dotfiles development](#dotfiles-development)
    - [Scripts](#scripts)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.

All scripts are licensed under the BSD 3 Clause license.

## Install

You can install these dotfiles by cloning the repository and using the
`bootstrap.sh` script, cloning and installing files manually, or by
using the webinstall script. **WARNING:** Installing via the webinstaller
**WILL** replace your `.bashrc`, `.zshrc`, and possibly other config files with
symlinks. Make sure to back them up.

Using `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rmj1001/dotfiles/main/webinstaller.sh)
```

Using `curl`:

```bash
bash <(curl -s https://raw.githubusercontent.com/rmj1001/dotfiles/main/webinstaller.sh)
```

## Distro Postinstall Scripts

There are post-install scripts for various distros in
`files/System32/postinstalls`. These scripts install common repositories and
software for development, gaming, media (codecs), and more. These scripts will
source the api since they need certain common functions.

## Dotfiles development

1. Do not mark lib scripts as executable, since they are used more like headers.
2. Do not declare global variables inside functions. Always use
`local <name>=""` to declare variables in functons.
3. Function names should be uppercase.
4. Functions should have comments with a description and usage example.
5. If functions assume global variables exist, make sure to include a default
value if the variable is empty.
Example: `${version:=1.0}`, where 1.0 is the default
6. Optional shell functionality should be developed in a separate plugin.
All plugins must be stored in `files/.shellfiles/plugins` and named as
`<plugin>`. Plugins can be sourced per-shell in their config file.

### Scripts

Scripts can be self-dependent, but we have also provided an API
to make developing shell scripts easier. To source the API, just
add the following lines to the beginning of a script. It's also
recommended to add any preprocessing (require/disable root,
require commands, etc.) before the rest of the script. It's also
recommended to add a commented header with author & basic script information.

```bash
#!/usr/bin/env bash

##############################################
#   Author: 
#   Project: 
#   Version: 1.0
#
#   Usage: 
#
#   Description:
#
##############################################

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

# Preprocessor flags
DISABLE_ROOT

####################################

```
