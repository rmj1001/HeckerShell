#!/usr/bin/env bash

PRINT()
{
	printf "%b\n" "$1"
}

LOWERCASE()
{
	local text="$1"
	printf "%b\n" "$text" | tr '[:upper:]' '[:lower:]'
}

_install()
{
	
}

_uninstall()
{
	
}

_help()
{
	
}

case "$(LOWERCASE $1)" in

	i | install ) _install ;;
	u | uninstall ) _uninstall ;;
	\? | h | help ) _help ;;
	* ) [[ -z "${1}" ]] && _help && exit 0 || PRINT "Invalid subcommand '$1'." && exit 1

esac
