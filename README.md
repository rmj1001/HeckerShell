# RMCJ's Dotfiles

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Warranty](#warranty)
- [Scripts](#scripts)
- [ZSH Plugins](#zsh-plugins)
- [Development Guidelines](#development-guidelines)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.

All scripts are licensed under the BSD 3 Clause license.

## Scripts

Scripts can be self-dependent, but we have also provided an API
to make developing shell scripts easier. To source the API, just
add the following lines to the beginning of a script. It's also
recommended to add any preprocessing (require/disable root, 
require commands, etc.) before the rest of the script.

```bash

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

# Preprocessor flags
DISABLE_ROOT

####################################

```

## ZSH Plugins

Any optional ZSH functionality should be made into a plugin. All plugins must be stored in `files/.zsh/plugins`,
and must be named as `<plugin>.zsh`. Plugins can be sourced in `files/.zsh/settings/01-zsh.zsh`.

## Development Guidelines

1. Do not mark lib scripts as executable, since they are used more like headers.
2. Do not declare global variables inside functions. Always use `local <name>=""` to declare variables in functons.
3. Function names should be uppercase.
4. Functions should have comments with a description and usage example.
5. If functions assume global variables exist, make sure to include a default value if the variable is empty.
Example: `${version:=1.0}`, where 1.0 is the default

