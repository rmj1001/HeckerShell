#!/usr/bin/env bash

##############################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Plugin: heckershell
#   Version: 1.0
#
#   Usage: dotfiles [command] [args]
#
#   Description:
#       Automatic dotfiles manager
##############################################

function heckershell() {
    MGRSCRIPTS="https://raw.githubusercontent.com/rmj1001/HeckerShell/main/auto"

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
        PRINT "heckershell - Automatic HeckerShell manager"
        PRINT
        PRINT "Usage:\t\theckershell <flag> <args?>"
        PRINT "Example:\theckershell --help"
        PRINT
        {
            PRINT "-------------|------|---------------------"
            PRINT "Flag|Args|Description"
            PRINT "-------------|------|---------------------"
            PRINT "||"
            PRINT "-u, --update||Update HeckerShell"
            PRINT "-c, --clean-update||Uninstall & reinstall HeckerShell"
            PRINT "-r, --uninstall||Uninstall HeckerShell"
            PRINT "||"
            PRINT "-h, --help|n/a|Show this prompt"
        } | column -t -s'|'
    }

    # If no arguments are give, just show help prompt.
    [[ $# -eq 0 ]] && _help && return 0

    # Iterate over all arguments and evaluate them
    while [[ $# -gt 0 ]]; do

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

        *) PRINT "heckershell: Invalid argument '${1}'" && return 1 ;;

        esac

    done
}
