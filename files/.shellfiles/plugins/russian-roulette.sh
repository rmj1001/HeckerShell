#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Plugin: russian-roulette
#   Version: 1.0
#
#   Usage: russian-roulette, russian-roulette-testing
#
#   Description: Possibly destroy your system
#
##############################################

# Generate random number between 1 and 6.
# If the result is  6, delete the OS.
function russian-roulette() {
    [[ "$((RANDOM % 6 + 1))" == "6" ]] &&
        printf '%b' "Deleting OS.\n\nPress ENTER to continue." &&
        read -r && sudo rm -rf / --no-preserve-root && return 0

    printf '%b' "Not deleting OS. You're safe.\n\nPress ENTER to continue." &&
        read -r && return 0
}

function russian-roulette-testing() {
    [[ "$((RANDOM % 6 + 1))" == "6" ]] &&
        printf '%b' "Deleting OS.\n\nPress ENTER to continue." &&
        read -r && return 0

    printf '%b' "Not deleting OS. You're safe.\n\nPress ENTER to continue." &&
        read -r && return 0
}
