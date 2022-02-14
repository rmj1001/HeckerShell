#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Plugin: backstreet
#   Version: 1.0
#
#   Usage: tellmewhy
#
#   Description: Ain't nothin but a heartache
#
##############################################

function tellmewhy() {
    [[ -z "$iters" ]] && iters=0

    local text=""

    function choose_text() {
        case "${iters}" in

        0) text="Ain't nothin but a heartache" ;;
        1) text="Ain't nothin but a mistake" ;;
        2) text="Now numbah 5" ;;
        3) text="I never wanna hear you say\n*I want it that way*" ;;
        *) iters=0 && choose_text ;;

        esac
    }

    choose_text
    echo "${text}"
    iters=$((iters + 1))
}
