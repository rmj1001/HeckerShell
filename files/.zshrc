#!/bin/zsh

#  ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗
#  ██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║
#  ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║
#  ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║
#  ██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
#  ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#

export SHELLFILES="${HOME}/.shellfiles"

# Source shellrc (common settings between bash and zsh)
for config in ${SHELLFILES}/*.sh; do
	source "${config}"
done

############################################################################
# PLACE ZSH-SPECIFIC SETTINGS IN HERE.

# Syntax Highlighting
export SYNTAXHIGH="${SHELLFILES}/.syntaxhighlighting"

# Install syntax highlighting if the
# ~/.shellfiles/.syntaxhighlighting folder is missing
[[ ! -d "${SYNTAXHIGH}" ]] &&
	printf "%b\n" "Installing syntax highlighting...\n" &&
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
		"${SYNTAXHIGH}" &&
	printf "%b\n" "" && read -s -k "?Press ENTER to continue." && clear

# Source syntax highlighting
source "${SYNTAXHIGH}"/zsh-syntax-highlighting.zsh

# Prompt
#export PS1='C:$(pwd | tr "////" "\\\\" ) > '
#export PS1='[ ${USER}@${HOSTNAME} ] ${PWD} > '
export PS1='[ ${USER}@${HOSTNAME} "$(basename "$(dirs)")" ]$ '
#export RPS1='$(date -u +"%m-%d-%Y %H:%M:%S")'
export RPS1='${PWD}'

# History
export HISTFILE="${HOME}/.zsh-history"
export HISTSIZE=1000
export SAVEHIST=1000

# ZSH Options
setopt +o nomatch
setopt NO_HUP
setopt AUTO_CD
setopt AUTO_MENU
#setopt LIST_ROWS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST

# Bound keys
bindkey ';5C' forward-word  # Ctrl ->
bindkey ';5D' backward-word # Ctrl <-
bindkey "\e[3~" delete-char # del

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

fpath=("$HOME"/.local/share/zsh-completions/src $fpath)
autoload -U compinit && compinit

############################################################################

"${SHELLFILES}"/00-plugin-loader.sh

shell fresh-screen

function precmd() {
	TITLE "${SHELL_TITLE}"
	for ((i = 0; i < $COLUMNS; ++i)); do
		printf -
	done

	printf "%b\n" ""
}
