#!/usr/bin/env bash
#
# Plugin Name: backstreet
# Description: Tell my why by backstreet boys
# Author(s): RMCJ <rmichael1001@gmail.com>
#

tellmewhy() {
    [[ -z "$iters" ]] && iters=0

    local text=""

    choose_text() {
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
