#!/usr/bin/env zsh
#
# Plugin Name: sudo
# Description: sudo or rootedit will be inserted before the command
# Author(s): RMCJ <rmichael1001@gmail.com>
#

__sudo-replace-buffer() {
    local old=$1 new=$2 space=${2:+ }
    if [[ ${#LBUFFER} -le ${#old} ]]; then
        RBUFFER="${space}${BUFFER#$old }"
        LBUFFER="${new}"
    else
        LBUFFER="${new}${space}${LBUFFER#$old }"
    fi
}

sudo-command-line() {
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

    # Save beginning space
    local WHITESPACE=""
    if [[ ${LBUFFER:0:1} = " " ]]; then
        WHITESPACE=" "
        LBUFFER="${LBUFFER:1}"
    fi

    # Get the first part of the typed command and check if it's an alias to $EDITOR
    # If so, locally change $EDITOR to the alias so that it matches below
    if [[ -n "$EDITOR" ]]; then
        local cmd="${${(Az)BUFFER}[1]}"
        if [[ "${aliases[$cmd]} " = (\$EDITOR|$EDITOR)\ * ]]; then
            local EDITOR="$cmd"
        fi
    fi

    if [[ -n $EDITOR && $BUFFER = $EDITOR\ * ]]; then
        __sudo-replace-buffer "$EDITOR" "rootedit"
    elif [[ -n $EDITOR && $BUFFER = \$EDITOR\ * ]]; then
        __sudo-replace-buffer "\$EDITOR" "rootedit"
    elif [[ $BUFFER = rootedit\ * ]]; then
        __sudo-replace-buffer "rootedit" "$EDITOR"
    elif [[ $BUFFER = sudo\ * ]]; then
        __sudo-replace-buffer "sudo" ""
    else
        LBUFFER="sudo $LBUFFER"
    fi

    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"
}

zle -N sudo-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line
