# Script Tips

Return [Home](..)

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

# Note: If you want to show a help prompt when the program is called with 0 args,
#       test for it outside the while loop.

while test $# -gt 0; do

    case "${1}" in
    
        --install ) shift; _install $1; shift ;;
    
        \? | -h | --help ) _help; exit 0 ;;
        
        * ) echo "Invalid subcommand '${1}'"; shift ;;
        
    esac

done

```
