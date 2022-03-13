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

### Print custom MOTD to terminal
# Usage: motd
function motd() {
    local disableMotdFile="${HECKERSHELL}/files/.noMOTD"

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

    case "$(LOWERCASE "${1}")" in
    -d | --disable)
        [[ ! -f "${disableMotdFile}" ]] && touch "${disableMotdFile}" &&
            PRINT "Disabled MOTD." && return 0

        PRINT "MOTD is already disabled."
        return 1
        ;;
    -e | --enable)
        [[ -f "${disableMotdFile}" ]] && rm -f "${disableMotdFile}" &&
            PRINT "Enabled MOTD." && return 0

        PRINT "MOTD is already enabled."
        return 1
        ;;
    -p | --force-print)
        printMotd
        ;;
    \? | -h | --help)
        PRINT "motd help\n---------"
        PRINT
        PRINT "-d, --disable\t\t# Disables the MOTD"
        PRINT "-e, --enable\t\t# Enables the MOTD"
        PRINT "-p, --force-print\t# Prints the MOTD even if its disabled."
        PRINT "\t\t\t# Leave blank to just print the MOTD if its enabled."
        ;;
    *)
        [[ -f "${disableMotdFile}" ]] && return 0
        printMotd
        ;;
    esac
}

### Write a line who's length is equal to the length of the terminal's columns
# Usage: write_lines
function write_lines() {
    for ((i = 0; i < COLUMNS; ++i)); do printf -; done
    PRINT ""
}

### Clear screen and print MOTD
## [flag] --no-clear: do not clear screen when printing
# Usage: freshscreen <flag?>
function freshscreen() {
    [[ "$(LOWERCASE "${1}")" == "--no-clear" ]] || clear

    motd

    [[ "${SHELL}" == "/bin/zsh" ]] && PRINT ""
}

### Reload shell
## [flag] --clean: Restart shell completely, not just reload HeckerShell
# Usage: reload <flag>
function reload() {
    # If clean flag isn't used then just reload sourced files
    [[ "$(LOWERCASE "${1}")" == "--clean" ]] || {
        shell.load
        return 0
    }

    # If clean flag is used then exec/restart the shell
    exec "$(basename "${SHELL}")"
}
