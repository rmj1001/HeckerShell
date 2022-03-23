#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: HeckerShell top-level
#                management code
#
##############################################

function shell() {
    ### Show the help menu for the shell management program.
    # Usage: shell help
    function shell.help() {

        PRINT "'shell' help\n---------"
        PRINT
        PRINT "reload\t\t# Reload shell configs"
        PRINT "fresh-screen\t# Clear screen and print MOTD"
        PRINT "lines\t\t# Print a width-covering line to the screen"
        PRINT "motd\t\t# Print or manage MOTD. See 'shell motd --help'."
        PRINT ""
        PRINT "help\t\t# See this help menu."
    }

    ### Reload shell files and present fresh screen.
    # Usage: shell reload
    function shell.reload() {
        exec "$(basename "${SHELL}")"
    }

    ### Write lines to terminal (full width of screen)
    # Usage: shell lines
    function shell.lines() {
        for ((i = 0; i < COLUMNS; ++i)); do printf -; done
        PRINT ""
    }

    ### Print custom MOTD to terminal
    # Usage: shell motd
    function shell.motd() {
        local DISABLE_MOTD="${HECKERSHELL}/files/.noMOTD"
        local CUSTOM_MOTD="${HECKERSHELL}/files/.customMOTD"

        printMotd() {
            PRINT "########################################################"
            PRINT "#"
            PRINT "# Roy Conn"
            PRINT "#"
            PRINT "# HeckerOS 1.0"
            PRINT "# HeckerShell 1.0"
            PRINT "#"
            PRINT "# Reddit \t u/rmj1001"
            PRINT "# Twitter \t @RoyConn10"
            PRINT "# Matrix \t @rmj1001:matrix.org"
            PRINT "# Mastodon \t @Hydra_Slash_Linux@foostodon.org"
            PRINT "# YouTube \t https://bit.ly/3qGsGSJ"
            PRINT "# Github \t https://github.com/rmj"
            PRINT "#"
            PRINT "########################################################"
        }

        printCustomMOTD() {
            [[ -f "${CUSTOM_MOTD}" ]] && cat "${CUSTOM_MOTD}" && return 0
            return 1
        }

        case "$(LOWERCASE "${1}")" in
        -d | --disable)
            [[ ! -f "${DISABLE_MOTD}" ]] && touch "${DISABLE_MOTD}" &&
                PRINT "Disabled MOTD." && return 0

            PRINT "MOTD is already disabled."
            return 1
            ;;
        -e | --enable)
            [[ -f "${DISABLE_MOTD}" ]] && rm -f "${DISABLE_MOTD}" &&
                PRINT "Enabled MOTD." && return 0

            PRINT "MOTD is already enabled."
            return 1
            ;;
        -c | --custom)
            [[ -f "${CUSTOM_MOTD}" ]] &&
                edit "${CUSTOM_MOTD}" &&
                PRINT "Edited custom MOTD." &&
                return 0

            PRINT "Creating custom MOTD..." && sleep 1
            edit "${CUSTOM_MOTD}"
            PRINT "Created custom MOTD!"
            return 0
            ;;
        -r | --delete-custom)
            [[ -f "${CUSTOM_MOTD}" ]] &&
                rm -f "${CUSTOM_MOTD}" &&
                PRINT "Deleted custom MOTD." &&
                return 0

            PRINT "Custom MOTD doesn't exist!"
            return 1
            ;;
        -p | --force-print)
            printCustomMOTD && return 0
            printMotd
            return 0
            ;;
        \? | -h | --help)
            PRINT "motd help\n---------"
            PRINT
            PRINT "-d, --disable\t\t# Disables the MOTD (default only)"
            PRINT "-e, --enable\t\t# Enables the MOTD (default only)"
            PRINT "-c, --custom\t\t# Create/edit a custom MOTD."
            PRINT "-r, --delete-custom\t# Delete custom MOTD."
            PRINT "-p, --force-print\t# Prints the MOTD even if its disabled."
            PRINT "\t\t\t# Leave blank to just print the MOTD if its enabled."
            ;;
        *)
            [[ -f "${DISABLE_MOTD}" ]] && return 0
            printCustomMOTD && return 0
            printMotd && return 0
            ;;
        esac
    }

    ### Clear screen and print motd
    # Usage: shell freshscreen
    function shell.fresh-screen() {
        clear
        shell.motd
        [[ "${SHELL}" == "/bin/zsh" ]] && PRINT ""
    }

    [[ $# -eq 0 ]] && shell.help && return 0

    case "$(LOWERCASE "${1}")" in
    help)
        shell.help
        return 0
        ;;
    reload)
        shell.reload
        return 0
        ;;
    fresh-screen)
        shell.fresh-screen
        return 0
        ;;
    lines)
        shell.lines
        return 0
        ;;
    motd)
        shift
        shell.motd "${@}"
        return 0
        ;;
    *)
        shell.help
        return 1
        ;;
    esac
}
