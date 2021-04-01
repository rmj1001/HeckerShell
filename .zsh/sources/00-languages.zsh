#!/usr/bin/env zsh

# NVM Variables
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export INIT="/usr/share/nvm/init-nvm.sh"

# NVM
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
[ -e "${INIT}" ] && . "${INIT}" # This initializes nvm

# Pyenv
if [ -d "$HOME/.pyenv" ]
then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

[[ `command -v pyenv` ]] && eval "$(pyenv init -)"

# Rust
[[ -e "${HOME}/.local/share/cargo/env" ]] && . "${HOME}/.local/share/cargo/env"
