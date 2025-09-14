# HeckerShell urls
export HECKERSHELL_SITE_HTTPS="https://github.com/rmj1001/HeckerShell.git"
export HECKERSHELL_SITE_SSH="git@github.com:rmj1001/HeckerShell.git"
export HECKERSHELL_SITE="${HECKERSHELL_SITE_HTTPS}"

# HeckerShell directories
export HECKERSHELL_DOWN_DIR="${HOME}/.local/share"
export HECKERSHELL_DIR="${HECKERSHELL_DOWN_DIR}/HeckerShell"
export HECKERSHELL="${HECKERSHELL_DIR}/files"

# OG Paths
export SYM_ZSHRC="${HECKERSHELL}/.zshrc"
export SYM_BASHRC="${HECKERSHELL}/.bashrc"
export SYM_SHELLFILES="${HECKERSHELL}/.shellfiles"
export SYM_SCRIPTS="${HECKERSHELL}/Scripts"

# Paths
export ZSHRC="${HOME}/.zshrc"
export BASHRC="${HOME}/.bashrc"
export SHELLFILES="${HOME}/.shellfiles"
export SCRIPTS="${HOME}/Scripts"

function PRINT() { printf '%b\n' "${@}"; }
function SYM() { ln -s "${@}"; }