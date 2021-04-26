#!/usr/bin/env zsh

### NIX ###

nixScript="${HOME}/.nix-profile/etc/profile.d/nix.sh"

if [[ -f "${nixScript}" ]]
then
	. "${nixScript}"
fi

### HOMEBREW ###

# Prefix Locations
homePrefix=${HOME}/.linuxbrew
userPrefix=/home/linuxbrew/.linuxbrew

# Determine Homebrew Prefix
[[ -d "${homePrefix}" ]] && export BREW_PREFIX="${homePrefix}"
[[ -d "${userPrefix}" ]] && export BREW_PREFIX="${userPrefix}"

# Evaluate the homebrew prefix's shellenv
eval "$(${BREW_PREFIX}/bin/brew shellenv)"

# Generated for envman. Do not edit.
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"
