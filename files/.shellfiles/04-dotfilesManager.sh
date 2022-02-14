#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: 04-dotfilesManager.sh
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: Dotfiles top-level
#                management code
#
##############################################

### Print custom MOTD to terminal
# Usage: motd
function motd() {
    PRINT "########################################################"
    PRINT "#"
    PRINT "# Roy Conn"
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

    [[ "${SHELL}" == "/bin/zsh" ]] && printf "%b\n" ""
}

### Reload shell
## [flag] --clean: Restart shell completely, not just reload dotfiles
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
