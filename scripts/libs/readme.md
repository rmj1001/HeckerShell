# Bash Library

This folder contains various scripts providing common bash
functions used in my scripts.

## Importing

Just copy/paste each needed function into your script. Importing
them will only make the scripts dependent on the master script, thus
making portability harder.

## Script File Guidelines

1. Each script should follow this format: `<name>.sh`
2. Do not mark lib scripts as executable, since they are used more like headers.
3. Scripts should always be housed in a subdirectory under `$SCRIPTS/libs`.

## Script Development Guidelines

1. Do not declare global variables. Always use `local <name>=""` to declare variables in functons.
2. Function names should be uppercase.
3. Functions should have comments with a description and usage example.
4. If functions assume global variables exist, make sure to include a default value if the variable is empty.
Example: `${version:=1.0}`, where 1.0 is the default
