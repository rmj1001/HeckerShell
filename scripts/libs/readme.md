# Bash Library

This folder will contain directories (modules) holding scripts
that provide advanced functions and code to bash scripts.

## Importing

To use a module, invoke 'api.lib.import' in your script.
This will source all shell scripts in a given directory.

## Script File Guidelines

1. Each script should follow this format: `##-name.sh`
2. Do not mark lib scripts as executable, since they are used more like headers.
3. Scripts should always be housed in a subdirectory under `$SCRIPTS/libs`.

## Script Development Guidelines

1. Do not declare variables in global scope.
2. Function names should be lowercase.
3. Function names should follow this format: `script.category.function`
4. Functions should have comments with a description and usage example.
5. Functions should only declare local variables. Example: `local tar="tar"`
6. If functions assume global variables exist, make sure to include a default value if the variable is empty. Example: `${version:=1.0}`, where 1.0 is the default
