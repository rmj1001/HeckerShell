# Dotfiles

## Table of Contents

- [Dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Warranty](#warranty)
  - [Scripts](#scripts)
    - [Function Importing](#function-importing)
    - [Development Guidelines](#development-guidelines)

## Warranty

These are the various scripts and configs I use on a daily basis.
THESE COME WITH NO WARRANTY, to the fullest extent of the law.

All scripts are licensed under the BSD 3 Clause license.

## Scripts

All scripts are self-dependent.
The folder `.local/bin/libs` contains various scripts providing common bash
functions used in my scripts. Scripts will never source one another.

Any scripts with dependencies will give an error message, should the dependencies be
missing.

### Function Importing

Just copy/paste each needed function into your script. Importing
them will only make the scripts dependent on the master script, thus
making portability harder.

### Development Guidelines

1. Each script should follow this format: `<name>.sh`
2. Do not mark lib scripts as executable, since they are used more like headers.
3. Do not declare global variables. Always use `local <name>=""` to declare variables in functons.
4. Function names should be uppercase.
5. Functions should have comments with a description and usage example.
6. If functions assume global variables exist, make sure to include a default value if the variable is empty.
Example: `${version:=1.0}`, where 1.0 is the default
