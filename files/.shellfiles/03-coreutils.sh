#!/bin/bash

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

############################ DEPENDENCIES ######################################

function check_homebrew() {
    brew list | grep "${@}"
}

function DEPENDENCY() {
    SILENTRUN check_homebrew "${1}" || brew install "${1}"
}

# Rust Coreutils
DEPENDENCY uutils-coreutils
DEPENDENCY uutils-findutils
DEPENDENCY uutils-diffutils
DEPENDENCY ugrep

# Cat alternative
DEPENDENCY bat

################################################################################
# Override builtin commands with uutils for interactive shell if uutils exists
HB_OPT="${HOMEBREW_PREFIX}/opt"

# experimental
[[ -d ${HB_OPT}/uutils-{coreutils,diffutils,findutils} ]] && \
    PATH = ${HB_OPT}/uutils-{coreutils,diffutils,findutils}/libexec/uubin:$PATH

# uncomment below if the above parameter expansion line does not work
#[[ -d "${HB_OPT}/uutils-coreutils" ]] && PATH="${HB_OPT}/uutils-coreutils/libexec/uubin:$PATH"
#[[ -d "${HB_OPT}/uutils-diffutils" ]] && PATH="${HB_OPT}/uutils-diffutils/libexec/uubin:$PATH"
#[[ -d "${HB_OPT}/uutils-findutils" ]] && PATH="${HB_OPT}/uutils-findutils/libexec/uubin:$PATH"

# Colorized grep
CMD_EXISTS ugrep && UNALIAS grep && grep() { ugrep --color=auto "${@}"; }

# Replace 'which'
UNALIAS which && which() { command -v "${@}"; }

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }
CMD_EXISTS bat && UNALIAS cat && cat() { bat "${@}"; }
