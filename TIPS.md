<!--
##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Script tips and tricks
#
##############################################
-->
# Script Tips

Return [Home](../README.md)

This file aims to provide bash scripters (mainly me)
with tips & tricks for creating immersive scripts.

## Commands & Flags

When developing scripts w/ subcommands and flags, you
should be familiar with case statements & for loops.

### Subcommands

```bash
#!/usr/bin/env bash

# Command evaluation
case "${1}" in

    v | version )

        # Usage: script v
        # Usage: script version
        printf "%b\n" "versions"
        ;;

esac
```

### Flags

```bash
#!/usr/bin/env bash

# Flag evaluation
# Shift once for every flag, shift again for each argument for that flag.

# NOTE: If you want to show a help prompt when the program is called with 0 args,
# test for it outside the while loop.
while [[ $# -gt 0 ]]; do

    case "${1}" in
    
        --install ) shift; _install $1; shift ;;
    
        \? | -h | --help ) _help; exit 0 ;;
        
        * ) echo "Invalid subcommand '${1}'"; shift ;;
        
    esac

done

```

### Formatted Help Menu

```bash
#!/usr/bin/env bash

# Creating and formatting a help menu
#
# One of the best ways to make a uniform help menu is to columnize
# the flags/commands portion. I also recommend adding in the name
# of the script in different sections via commands, so that if the
# file changes then you don't need to manually update the help menu.
function _help() {
    printf '%b\n' "$(basename "$(readlink -nf "$0")") - description"
    printf '%b\n'
    printf '%b\n' "Usage:\t\t$(basename "$(readlink -nf "$0")") [FLAGS] [ARGS?] ..."
    printf '%b\n' "Example:\t$(basename "$(readlink -nf "$0")") --help"
    printf '%b\n'
    {
        printf '%b\n' "-------------|------|---------------------"
        printf '%b\n' "Flag|Args|Description"
        printf '%b\n' "-------------|------|---------------------"
        printf '%b\n' "||"
        printf '%b\n' "-h, --help|n/a|Show this prompt"
    } | column -t -s'|'
}
```
