# Dotfiles Development Guidelines

Return [Home](../README.md)

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

## Script Guidelines

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
