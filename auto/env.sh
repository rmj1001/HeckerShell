#!/usr/bin/env bash

DOTFILES_SITE_HTTPS="https://github.com/rmj1001/dotfiles.git"
DOTFILES_SITE_SSH="git@github.com:rmj1001/dotfiles.git"
DOTFILES_SITE="${DOTFILES_SITE_HTTPS}"

DOTFILES_DOWN_DIR="${HOME}/.local/share"
DOTFILES_DIR="${DOTFILES_DOWN_DIR}/dotfiles"
DOTFILES="${DOTFILES_DIR}/files"

# OG Paths
SYM_ZSHRC="${DOTFILES}/.zshrc"
SYM_BASHRC="${DOTFILES}/.bashrc"
SYM_SHELLFILES="${DOTFILES}/.shellfiles"
SYM_SCRIPTS="${DOTFILES}/System32"

# Paths
ZSHRC="${HOME}/.zshrc"
BASHRC="${HOME}/.bashrc"
SHELLFILES="${HOME}/.shellfiles"
SCRIPTS="${HOME}/System32"
