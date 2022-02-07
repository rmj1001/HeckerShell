# Dotfiles Development Guidelines

Return [Home](../README.md)

## General Guidelines

1. Headers must be named `00-name.sh`.
2. Do not mark header scripts as executable.
3. Function names should be uppercase.
4. Functions should have comments with a description and usage example.
5. Do not declare global variables inside functions. Always use `local <name>=""` to declare variables in functons.
6. If functions assume global variables exist, make sure to include a default value if the variable is empty.
   - Example: `${version:=1.0}`, where 1.0 is the default.

For some tips on developing scripts/plugins, see [here](script-tricks.md).

## Script Guidelines

1. Scripts must not source other scripts. Headers are the exception.
2. Scripts should source the API header (`00-api.sh`) for common functionality.
3. Make sure to include preprocessing commands (require/disable root, require commands, etc.) before the main logic of the script.
4. Make sure a commented header with the author & basic script info is included at the top of the script.

See script template [here](../files/System32/00-template.sh).

## Plugin Guidelines

1. Optional or shell-specific functionality must be developed as a plugin.
2. Plugins must be stored in `files/.shellfiles/plugins` and named as `plugin.sh`
3. Plugins must be enabled in `files/.shellfiles/configs/<shell>.sh`.
4. Do not source `00-template.sh`. This is only meant to provide boilerplate code.

See plugin template [here](../files/.shellfiles/plugins/00-template.sh).
