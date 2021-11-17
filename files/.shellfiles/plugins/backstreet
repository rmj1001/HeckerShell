#!/usr/bin/env zsh
#
# Plugin Name: backstreet
# Description: Tell my why by backstreet boys
# Author(s): RMCJ <rmichael1001@gmail.com>
#

tellmewhy() {
    [[ -z "$iters" ]] && iters=0

    if (( $iters == 0 )); then

        echo "Ain't nothin but a heartache"
        iters=$(( $iters + 1 ))
    
    elif (( $iters == 1 )); then

        echo "Ain't nothin but a mistake"
        iters=$(( $iters + 1 ))

    elif (( $iters == 2 )); then

        echo "I never wanna hear you say"
        echo "*I want it that way*"
        iters=0

    fi
}
