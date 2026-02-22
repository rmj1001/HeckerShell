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
    if ! SILENTRUN check_homebrew ${1}; then
        brew install ${1}
    fi
}

# Rust Coreutils
DEPENDENCY uutils-coreutils
DEPENDENCY uutils-findutils
DEPENDENCY uutils-diffutils
DEPENDENCY ugrep

# Cat alternative
DEPENDENCY bat

################################################################################

# Colorized grep
if CMD_EXISTS ugrep; then
    UNALIAS grep
    function grep() { ugrep --color=auto "${@}"; }
fi

# Replace 'which'
UNALIAS which && function which() { command -v "${@}"; }
#REPLACE which 'command -v'

# If bat/batcat exists, create opposite alias to replace cat
CMD_EXISTS batcat && function bat() { batcat -P "${@}"; }


if CMD_EXISTS bat; then
    UNALIAS cat
    function cat() { bat "${@}"; }
elif CMD_EXISTS ucat; then
    UNALIAS cat
    function cat() { ucat "${@}"; }
fi


# Override builtin commands with uutils for interactive shell if uutils exists
HB_OPT="${HOMEBREW_PREFIX}/opt"
[[ -d "${HB_OPT}/uutils-coreutils" ]] && PATH="${HB_OPT}/uutils-coreutils/libexec/uubin:$PATH"
[[ -d "${HB_OPT}/uutils-diffutils" ]] && PATH="${HB_OPT}/uutils-diffutils/libexec/uubin:$PATH"
[[ -d "${HB_OPT}/uutils-findutils" ]] && PATH="${HB_OPT}/uutils-findutils/libexec/uubin:$PATH"
