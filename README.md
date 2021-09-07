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

All scripts are self-dependent.
The folder `files/System32/libs` contains various scripts providing common bash
functions used in my scripts. Just copy/paste each needed function into your script. Importing
them will only make the scripts dependent on the master script, thus
making portability harder.

If a script requires dependencies, and the dependencies are missing, the script should
throw an error.

## ZSH Plugins

Any optional ZSH functionality should be made into a plugin. All plugins must be stored in `files/.zsh/plugins`,
and must be named as `<plugin>.zsh`.

## Development Guidelines

1. Do not mark lib scripts as executable, since they are used more like headers.
2. Do not declare global variables. Always use `local <name>=""` to declare variables in functons.
3. Function names should be uppercase.
4. Functions should have comments with a description and usage example.
5. If functions assume global variables exist, make sure to include a default value if the variable is empty.
Example: `${version:=1.0}`, where 1.0 is the default
