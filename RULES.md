<!--
##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Developer Guidelines
#
##############################################
-->
# HeckerShell Development Guidelines

Return [Home](../README.md)

## General Guidelines

1. Headers must be named `00-name.sh`.
2. Do not mark header scripts as executable.
3. All function names should use the `function` keyword.
4. Functions should have comments with a description and usage example.
5. Do not declare global variables inside functions. Always use `local <name>=""` to declare variables in functons.
6. If functions assume global variables exist, make sure to include a default value if the variable is empty.
   - Example: `${version:=1.0}`, where 1.0 is the default.

For some tips on developing scripts/plugins, see [here](script-tricks.md).

## HeckerShell Configs Guidelines

1. All files that hold shell code (excluding scripts) must be named as `<file>.sh`.
2. Shell-specific settings are stored in their respective `rc` file.
3. Environment variables are stored in `files/.shellfiles/01-environment.sh`.
4. Functions (aliases) are stored in `files/.shellfiles/02-functions.sh`.
5. Sourced settings are stored in `files/.shellfiles/03-sources.sh`.
6. The MOTD is stored in `files/.shellfiles/04-motd.sh`.
7. Distro postinstall scripts are stored in `files/Postinstallers`.
8. Optional or shell-specific functionality must be developed as a plugin.
9. When hacking on HeckerShell, make use of these commands. NOTE: Use `command ?` to see their help menu.
   1. `heckershell` - Update/clean/uninstall HeckerShell
   2. `shell reload` - Reload shell configs (use `--clean` flag if hacking on `<shell>rc` files.).
   3. `scriptctl` - Create/manage script files

## Script Guidelines

1. Scripts are stored in `files/Scripts`.
2. Scripts must be named as `<command>`.
3. Scripts must not source other scripts. Headers are the exception.
4. Scripts should source the API header (`00-api.sh`) for common functionality.
5. Make sure to include preprocessing commands (require/disable root, require commands, etc.) before the main logic of the script.
6. Make sure a commented header with the author & basic script info is included at the top of the script.

See script template [here](../files/Scripts/00-template.sh).

## Plugin Guidelines

1. Plugins are stored in `files/.shellfiles/plugins`.
2. Plugins must be named as `<plugin>.sh`
3. Plugins must not source other plugins.
4. Plugins must be enabled in `files/.shellfiles/configs/<shell>.sh`.
5. Do not source `00-template.sh`. This is only meant to provide boilerplate code.
6. Make sure a commented header with the author & basic script info at the top.

See plugin template [here](../files/.shellfiles/plugins/00-template.sh).
