#!/usr/bin/env bash

##############################################
#   Author(s): RMCJ <rmichael1001@gmail.com>
#   Project: HeckerShell
#   Plugin: fedora-silverblue
#   Version: 1.0
#
#   Usage: dnf
#
#   Description: Aliases for Fedora Silverblue
#
##############################################

# Alias for 'rpm-ostree', replaces certain subcommands with custom implementations
function dnf() {

	function _help() {
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

	function _install() {
		rpm-ostree install -A
	}

	while [[ $# -gt 0 ]]; do

		case "${1}" in

		--dnf-install)
			shift
			_install "$@"
			;;

		\? | --dnf-help)
			shift
			_help
			;;

		*)
			shift
			[[ $# -gt 0 ]] || { rpm-ostree -h && continue; }
			rpm-ostree "$@"
			;;

		esac

	done
}
