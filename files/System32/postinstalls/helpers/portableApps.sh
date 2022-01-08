#!/usr/bin/env bash

##############################################
#   Author: Roy Conn
#   Project: Portable Apps installation helper
#   Version: 1.0
#
#   Usage: portableApps.sh
#
#   Description:
#		Install distro-agnostic software
##############################################

# Zap Appimage PM (requires jq)
curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh |
    bash -s

zap init
zap daemon --install

# Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"