# Script Tips

This file aims to provide bash scripters (mainly me)
with tips & tricks for creating immersive scripts.

## Commands & Flags

When developing scripts w/ subcommands and flags, you
should be familiar with case statements & for loops.

### Subcommands

```bash
#!/usr/bin/env bash

# Command evaluation
case "$1" in

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

ARGUMENTS="$@"

# Flag evaluation
# Loops over all subtext after a command to find flags
for ((i = 0 ; i < ${#ARGUMENTS[@]} ; i++)); do

    j=$((i + 1))
    arg=${ARGUMENTS[@]}

    case ${ARGUMENTS[i]} in

        -f | --flag )

        FLAG="$arg"
        ;;

    esac

done
```
