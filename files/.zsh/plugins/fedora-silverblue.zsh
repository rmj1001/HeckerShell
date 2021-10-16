#!/usr/bin/env zsh
#
# Plugin Name: fedora-silverblue
# Description: Aliases for Fedora Silverblue
# Author(s): Roy Conn
#

# Alias for 'rpm-ostree', replaces certain subcommands with custom implementations
function dnf () {

	_help () {
		PRINT "dnf - An alias for 'rpm-ostree' on Fedora Silverblue"
		PRINT "Note: This command uses the same syntax as 'rpm-ostree', but adds"
		PRINT "      custom flags for aliases for subcommands."
		PRINT
		PRINT "Flags:"
		PRINT "--dnf-install\t\tInstall RPMs and apply live to image."
		PRINT
		PRINT "--dnf-help\t\tShow this prompt"
		PRINT ""
	}

	_install () {
		rpm-ostree install -A
	}

	while test $# -gt 0; do

		case "${1}" in

			--dnf-install )
				shift
				_install $@
				;;

			\? | --dnf-help )
				shift
				_help
				;;

			* )
				shift
				[[ $# -gt 0 ]] && rpm-ostree $@ || rpm-ostree -h
				;;

		esac

	done
}
