#!/usr/bin/env sh

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Version: 1.0
#
#   Usage: n/a
#
#   Description: POSIX-compliant manager for Heckershell
#
##############################################

# HeckerShell urls
export HECKERSHELL_SITE_HTTPS="https://github.com/rmj1001/HeckerShell.git"
export HECKERSHELL_SITE_SSH="git@github.com:rmj1001/HeckerShell.git"
export HECKERSHELL_SITE="${HECKERSHELL_SITE_HTTPS}"

# HeckerShell directories
export HECKERSHELL_DOWN_DIR="${HOME}/.local/share"
export HECKERSHELL_DIR="${HECKERSHELL_DOWN_DIR}/HeckerShell"
export HECKERSHELL="${HECKERSHELL_DIR}/files"

# OG Paths
export SYM_ZSHRC="${HECKERSHELL}/.zshrc"
export SYM_BASHRC="${HECKERSHELL}/.bashrc"
export SYM_SHELLFILES="${HECKERSHELL}/.shellfiles"
export SYM_SCRIPTS="${HECKERSHELL}/Scripts"

# Paths
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/Scripts"

# Checks to see an input matches case-insensitive 'yes'
isYes() {
    echo "$1" | grep '^[yY][eE]?[sS]?$' && return 0
    return 1
}

### Show the help menu for the shell management program.
# Usage: shell help
shell_help() {
    PRINT "'shell' help\n---------"
    PRINT
    PRINT "reload\t\t# Reload shell configs"
    PRINT "fresh-screen\t# Clear screen and print MOTD"
    PRINT "lines\t\t# Print a width-covering line to the screen"
    PRINT "motd\t\t# Print or manage MOTD. See 'shell motd --help'."
    PRINT ""
    PRINT "update\t\t# Update the shell"
    PRINT "clean-update\t# Uninstall & Re-install shell"
    PRINT "uninstall\t# Uninstall this shell manager"
    PRINT ""
    PRINT "help\t\t# See this help menu."
}

### Reload shell files and present fresh screen.
# Usage: shell reload
shell_reload() {
    exec "$(basename "${SHELL}")"
}

### Write lines to terminal (full width of screen)
# Usage: shell lines
shell_lines() {
    i=0
    while test i -lt $COLUMNS; do
        printf -
        i=$((i + 1))
    done
}

# Print custom MOTD to terminal
# Usage: shell motd
shell_motd() {
    DISABLE_MOTD="${HECKERSHELL}/files/.noMOTD"
    CUSTOM_MOTD="${HECKERSHELL}/files/.customMOTD"

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
        [ -f "${CUSTOM_MOTD}" ] && cat "${CUSTOM_MOTD}" && return 0
        return 1
    }

    case "$(LOWERCASE "${1}")" in
    -d | --disable)
        [ ! -f "${DISABLE_MOTD}" ] && touch "${DISABLE_MOTD}" &&
            PRINT "Disabled MOTD." && return 0

        PRINT "MOTD is already disabled."
        return 1
        ;;
    -e | --enable)
        [ -f "${DISABLE_MOTD}" ] && rm -f "${DISABLE_MOTD}" &&
            PRINT "Enabled MOTD." && return 0

        PRINT "MOTD is already enabled."
        return 1
        ;;
    -c | --custom)
        [ -f "${DISABLE_MOTD}" ] &&
            edit "${CUSTOM_MOTD}" &&
            PRINT "Edited custom MOTD." &&
            return 0

        PRINT "Creating custom MOTD..." && sleep 1
        edit "${CUSTOM_MOTD}"
        PRINT "Created custom MOTD!"
        return 0
        ;;
    -r | --delete-custom)
        [ -f "${DISABLE_MOTD}" ] &&
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
        [ -f "${DISABLE_MOTD}" ] && return 0
        printCustomMOTD && return 0
        printMotd && return 0
        ;;
    esac
}

### Clear screen and print motd
# Usage: shell freshscreen
shell_freshscreen() {
    clear
    shell_motd
    [ "${SHELL}" = "/bin/zsh" ] && PRINT ""
}

shell_install() {
    # Check if Git is installed.
    [ ! -x "$(command -v git)" ] &&
        PRINT "Git is not installed." && {
        sleep 0.5
        exit 1
    }

    # Confirm installation
    printf "%b" "Are you sure you want to install this? (y/N) "
    read -r confirm

    isYes "${confirm}" || {
        PRINT "Cancelling."

        sleep 0.5
        exit 1
    }

    # Check if HeckerShell exist
    [ -d "${HECKERSHELL_DIR}" ] && {
        PRINT "HeckerShell directory exists. Try using the update script."
        PRINT "Exiting..."

        sleep 0.5
        exit 1
    }

    # If user wishes to contribute, use SSH
    sleep 0.5
    printf "%b" "Will you be contributing to HeckerShell? (y/N) "
    read -r contrib

    isYes "${contrib}" && HECKERSHELL_SITE="${HECKERSHELL_SITE_SSH}"

    # Download HeckerShell
    sleep 0.5
    PRINT "Downloading HeckerShell..."
    cd "${HECKERSHELL_DOWN_DIR}" || exit 1
    git clone "${HECKERSHELL_SITE}"

    # Install scripts
    sleep 0.5
    PRINT "Installing scripts..."
    SYM "${SYM_SCRIPTS}" "${SCRIPTS}"

    # Install shellfiles
    sleep 0.5
    PRINT "Installing shell configs..."
    rm -f "${ZSHRC}" && SYM "${SYM_ZSHRC}" "${ZSHRC}" && sleep 0.5
    rm -f "${BASHRC}" && SYM "${SYM_BASHRC}" "${BASHRC}" && sleep 0.5
    SYM "${SYM_SHELLFILES}" "${SHELLFILES}" && sleep 0.5

    # Remove rogue symlinks
    sleep 0.5
    PRINT "Removing rogue symlinks..."
    [ -L "${SHELLFILES}/.shellfiles" ] && rm -f "${SHELLFILES}/.shellfiles"

    # Install miscellany configs
    sleep 0.5
    PRINT "Installing miscellaneous configs..."

    for folder in "${HECKERSHELL}"/.config/*; do
        name="$(basename "${folder}")"
        sym="${HOME}/.config/${name}"

        sleep 0.5

        PRINT "Installing config '${name}'..."

        [ -L "${sym}" ] || SYM "${folder}" "${sym}"

    done

    # Ask if they wish to print the MOTD
    printf "%b" "Use default MOTD? (y/N) "
    read -r confirm

    isYes "${confirm}" || {
        PRINT "Disabling default motd."
        touch "${HECKERSHELL}/.noMOTD"
    }

    # Finish
    PRINT "HeckerShell installed to '${HECKERSHELL_DIR}'."

    PRINT "Tips:"
    PRINT "- Use 'shell motd ?' to enable/disable/customize your MOTD."
    PRINT "- Use 'shell fresh-screen' to clear the screen and print the MOTD."
    PRINT "- Use 'shell reload' to reload the shell configuration."

}

shell_uninstall() {
    # Check if Git is installed.
    [ ! -x "$(command -v git)" ] &&
        PRINT "Git is not installed." && exit 1

    # Confirm uninstallation
    printf "%b" "Are you sure you want to uninstall this? (y/N) "
    read -r confirm

    PRINT ""

    isYes "${confirm}" || {
        PRINT "Cancelling."
        exit 1
    }

    # Uninstall scripts
    PRINT "Uninstalling scripts..."
    [ -L "${SCRIPTS}" ] && rm -f "${SCRIPTS}"

    # Uninstall shell files
    PRINT "Uninstalling shell configs..."
    [ -L "${ZSHRC}" ] || rm -f "${ZSHRC}"
    [ -L "${BASHRC}" ] || rm -f "${BASHRC}"
    [ -L "${SHELLFILES}" ] || rm -f "${SHELLFILES}"

    # Uninstall miscellany configs
    PRINT "Uninstalling miscellaneous configs..."

    for folder in "${HECKERSHELL}"/.config/*; do
        linkRef="${folder##*/}"
        sym="${HOME}/.config/${linkRef}"

        PRINT "Uninstalling config ${linkRef}..."

        [ -L "${sym}" ] && rm -f "${sym}"
    done

    # Delete HeckerShell
    PRINT "Deleting HeckerShell..."
    rm -rf "${HECKERSHELL_DIR}"

    # Finish
    PRINT "Done."

}

shell_update() {
    [ -x "$(command -v git)" ] || { PRINT "" \
        'git must be installed.' && exit 1; }

    cd "${HECKERSHELL_DIR}" || { PRINT 'HeckerShell does not exist.' && exit 1; }

    # Confirm uninstallation
    printf "%b" "Are you sure you want to update? Changes you made will be lost. (y/N) "
    read -r confirm

    PRINT ""

    isYes "${confirm}" || {
        PRINT "Cancelling."
        exit 1
    }

    git pull

}

shell_cleanupdate() {
    shell_uninstall
    shell_install
}

shell() {
    [ $# -eq 0 ] && shell_help && return 0

    case "$(LOWERCASE "${1}")" in
    help)
        shell_help
        return 0
        ;;
    reload)
        shell_reload
        return 0
        ;;
    fresh-screen)
        shell_freshscreen
        return 0
        ;;
    lines)
        shell_lines
        return 0
        ;;
    motd)
        shift
        shell_motd "${@}"
        return 0
        ;;
    update)
        shift
        shell_update
        return 0
        ;;
    clean-update)
        shift
        shell_cleanupdate
        return 0
        ;;
    uninstall)
        shift
        shell_uninstall
        return 0
        ;;
    *)
        shell_help
        return 1
        ;;
    esac
}
