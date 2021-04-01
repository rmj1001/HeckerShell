#!/usr/bin/env zsh

vte="/etc/profile.d/vte.sh"

if [[ $TILIX_ID ]] || [[ $VTE_VERSION ]]; then

	[[ -f "${VTE}" ]] && . "${VTE}"

fi
