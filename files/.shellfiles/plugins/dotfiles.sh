#!/usr/bin/env bash

##############################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Plugin: dotfiles
#   Version: 1.0
#
#   Usage: dotfiles [command] [args]
#
#   Description:
#       Automatic dotfiles manager
##############################################

function dotfiles() {
    MGRSCRIPTS="https://raw.githubusercontent.com/rmj1001/dotfiles/main/auto"

    function _update() {
        bash <(wget -qO- ${MGRSCRIPTS}/update.sh)
    }

    function _cleanupdate() {
        bash <(wget -qO- ${MGRSCRIPTS}/uninstall.sh)
        bash <(wget -qO- ${MGRSCRIPTS}/install.sh)
    }

    function _uninstall() {
        bash <(wget -qO- ${MGRSCRIPTS}/uninstall.sh)
    }

    function _help() {
        PRINT "dotfiles - Automatic dotfiles manager script"
        PRINT
        PRINT "Usage:\t\tdotfiles <flag> <args?>"
        PRINT "Example:\tdotfiles --help"
        PRINT
        {
            PRINT "-------------|------|---------------------"
            PRINT "Flag|Args|Description"
            PRINT "-------------|------|---------------------"
            PRINT "||"
            PRINT "-u, --update||Update dotfiles"
            PRINT "-c, --clean-update||Uninstall & reinstall dotfiles"
            PRINT "-r, --uninstall||Uninstall dotfiles"
            PRINT "||"
            PRINT "-h, --help|n/a|Show this prompt"
        } | column -t -s'|'
    }

    # If no arguments are give, just show help prompt.
    [[ $# -eq 0 ]] && _help && return 0

    # Iterate over all arguments and evaluate them
    while test $# -gt 0; do

        case "$(LOWERCASE "${1}")" in

        -u | --update)
            shift
            _update
            return 0
            ;;

        -c | --clean-update)
            shift
            _cleanupdate
            return 0
            ;;

        -r | --uninstall)
            shift
            _uninstall
            return 0
            ;;

        \? | -h | --help)
            shift
            _help
            return 0
            ;;

        *) PRINT "dotfiles: Invalid argument '${1}'" && return 1 ;;

        esac

    done
}
