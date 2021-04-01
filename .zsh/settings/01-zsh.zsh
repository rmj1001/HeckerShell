#!/usr/bin/env zsh

# ZSH Options
setopt +o nomatch
setopt NO_HUP
zstyle ':completion:*' rehash true

################################################################################################
# ZSH_THEME                       - OhMyZSH theme name, set to "random" to load a random theme.
# ZSH_THEME_RANDOM_CANDIDATES     - Array of themes to pick when loading from random
#                                 - ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#
# HYPHEN_INSENSITIVE              - Use hyphen-insensitive completion
# DISABLE_AUTO_UPDATE             - disable bi-weekly auto-update checks
# DISABLE_UPDATE_PROMPT           - automatically update without prompting
# DISABLE_MAGIC_FUNCTIONS         - set to true if pasting urls/text is messed up.
# DISABLE_AUTO_TITLE              - disable auto-setting terminal title
# ENABLE_CORRECTION               - Enable command auto-correction
# COMPLETION_WAITING_DOTS         - display red dots whilst waiting for completion
# DISABLE_UNTRACTED_FILES_DIRTY   - Disable marking untracked files under VCS as dirty
################################################################################################

HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
ZSH_THEME="robbyrussell"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    git
    themes
    zsh-syntax-highlighting
)

# Source OhMyZsh
[[ -f ${ZSH}/oh-my-zsh.sh ]] && . ${ZSH}/oh-my-zsh.sh
