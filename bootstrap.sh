#!/usr/bin/env bash

DOTFILES="$(dirname "$(readlink -f "$0")")/files"

# OG Paths
SYM_ZSHRC="$DOTFILES/.zshrc"
SYM_ZSH="$DOTFILES/.zsh"
SYM_SCRIPTS="$DOTFILES/.local/bin"

# Paths
ZSHRC="$HOME/.zshrc"
ZSH="$HOME/.zsh"
SCRIPTS="$HOME/.local/bin"

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
	PRINT

	# Scripts
	PRINT "Installing scripts..."
	[[ -h "$SYM_SCRIPTS" ]] || ln -s $SYM_SCRIPTS $SCRIPTS
	
	# ZSH
	PRINT "Installing ZSH config..."
	[[ -h "$SYM_ZSHRC" ]] || ln -s $SYM_ZSHRC $ZSHRC
	[[ -h "$SYM_ZSH" ]] || ln -s $SYM_ZSH $ZSH
	
	# Configs
	PRINT "Installing miscellaneous configs..."

	local linkRef;
	local sym;

	for folder in $DOTFILES/.config/*
	do
		linkRef="${folder##*/}"
		sym="$HOME/.config/$linkRef"

		PRINT "Installing config ${linkRef}..."
		
		[[ -h "$sym" ]] || ln -s $folder $sym
	done

	PRINT "Done."
}

_uninstall()
{
	PRINT

	# Scripts
	PRINT "Removing scripts symlink..."
	[[ -h "$SYM_SCRIPTS" ]] && rm $SYM_SCRIPTS

	# ZSH
	PRINT "Removing ZSH config symlinks..."
	[[ -h "$SYM_ZSHRC" ]] && rm $SYM_ZSHRC
	[[ -h "$SYM_ZSH" ]] && rm $SYM_ZSH
	
	# Configs
	PRINT "Removing miscellaneous configs..."

	local linkRef;
	local sym;

	for folder in $DOTFILES/.config/*
	do
		linkRef="${folder##*/}"
		sym="$HOME/.config/$linkRef"

		PRINT "Removing config ${linkRef}..."

		[[ -h "$sym" ]] && rm "$sym"
	done

	PRINT "Done."
}

_help()
{
	_help.commands()
	{
		PRINT "Command|Arguments|Description"
		PRINT "(i) install||Install dotfiles to the system"
		PRINT "(u) uninstall||Remove dotfiles from the system"
		PRINT "(h) help||Show this help menu"
	}

	PRINT
	PRINT "Install/Uninstall symlinks to important dotfiles"
	PRINT
	PRINT "Usage:\t\tbootstrap.sh <command>"
	PRINT "Example:\tbootstrap.sh install"
	PRINT
	_help.commands | column -t -s "|"
}

case "$(LOWERCASE $1)" in

	i | install ) _install ;;
	u | uninstall ) _uninstall ;;
	\? | h | help ) _help ;;
	* ) [[ -z "${1}" ]] && _help && exit 0 || PRINT "Invalid subcommand '$1'." && exit 1

esac
