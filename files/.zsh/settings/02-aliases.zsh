#!/usr/bin/env zsh

############################## SHELL ALIASES ##############################

# Edit files
alias edit="${EDITOR}"
alias rootedit="${AUTH} ${EDITOR}"

# Copy text from STDIN or from a file
alias copy="xclip -sel clip"

# Colorized grep
alias grep="grep --color=auto"

# Cat a file w/ line numbers
alias readfile="/bin/cat -n"

# Replaces 'cat' with 'batcat' (Rust rewrite)
if [[ -x "$(command -v batcat)" ]]; then
	alias bat="/bin/batcat"
	alias cat="bat -p"
fi

# Replaces 'cat' with 'bat' on Arch (Rust rewrite)
if [[ -x "$(command -v bat)" ]] && [[ -x "$(command -v pacman)" ]]; then
	alias cat="bat -p"
fi

# Listing files/directories
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -AlvhF"
alias la="ls -A"
alias l.="la | grep '^\.\w\w*$'"

# Directory manipulation
alias mkdir="mkdir -p"
alias md="mkdir"
alias mf="touch"
alias rd="rm -rf"
alias rf="rm -f"
alias rmcd="dir=${PWD}; cd ${dir}/.. && rm -rf ${dir}"
mkcd () { mkdir "${1}" && cd "${1}" }

# File Permissions (Exec/Non-exec)
alias mke="chmod +x"
alias rme="chmod 644"

# Update software from source
alias makeupdate="git pull && sudo make uninstall && make clean && make && sudo make install"

# Home
alias home="cd ${HOME}"

# ZSH management
alias zreload="clear; exec ${SHELL}"
alias zmanage="cd ${HOME}.zsh"
alias zshrc="${EDITOR} ${ZSHRC}"
alias zaliases="${EDITOR} ${HOME}/.zsh/settings/02-aliases.zsh && zreload"

# Default apps
alias terminal="${TERMINAL}"
alias browser="${BROWSER}"
alias auth="${AUTH}"

############################## SHELL FUNCTIONS ##############################

### Print text to STDOUT without 'echo'
# usage: PRINT "<text>"
PRINT() { printf "%s\n" "${@}" && return 0 }

### Run programs silently in the background
# usage: silentrun <program> [args?]
SILENTRUN() { $@ 2>&1 > /dev/null &! }

### Run programs in the background in disowned processes
# usage: ASYNC '<commands>'
ASYNC() { nohup $@ > /dev/null 2>&1 & }

### Make all text uppercase
# usage: UPPERCASE "text" -> "TEXT"
UPPERCASE() { PRINT "$1" | tr '[:lower:]' '[:upper:]' }

### Make all text lowercase
# usage: LOWERCASE "TEXT" -> "text"
LOWERCASE() { PRINT "$1" | tr '[:upper:]' '[:lower:]' }

### Random number generator
# usage: random <number?>
random() { PRINT "$(( 1 + ${RANDOM} % ${1:-100} ))" }

### Message of the Day
# usage: motd
motd ()
{
    local _motd="${HOME}/.zsh/motd.txt"

    [[ -f "${_motd}" ]] || return 0

    [[ "$1" == '--lolcat' ]] && [[ -x "$(command -v lolcat)" ]] && lolcat ${_motd} && return 0
    [[ "$1" == '--edit' ]] && ${EDITOR} ${_motd} && return 0

    cat ${_motd}
}

########################## CURL APPS ##########################

### CURL APPS HELP
# usage: curlapps
curlapps()
{
    printf "%b\n" "cheat \t\t [command]"
    printf "%b\n" "weather"
    printf "%b\n" "qrcode \t\t [url]"
    printf "%b\n" "dict \t\t [word]"
    printf "%b\n" "rate \t\t [emtpy or currency]"
    printf "%b\n" "getnews \t [query]"
    printf "%b\n" "parrot"
}

### CHEAT PAGES
# usage: cheat <command>
cheat()
{
    curl cheat.sh/$1
}

### WEATHER
# usage: weather
weather()
{
    curl wttr.in
}

### QR CODE CREATOR
# usage: qrcode <link>
qrcode()
{
    curl qrenco.de/$1
}

### DICTIONARY
# usage: dict <word>
dict()
{
    curl dict://dict.org/d:$1
}

### CRYTPOCURRENCY RATES
# usage: rate <cryptocurrency symbol>
rate ()
{
    curl rate.sx/$1
}

### URL SHORTENER
# usage: urlshorten <link>
urlshorten()
{
    curl -F "shorten=$1" https://0x0.st
}

### NEWS READER
# usage: getnews <topic>
getnews()
{
    curl getnews.tech/$1
}

### PARROT IN TERMINAL
# usage: parrot
parrot()
{
    curl parrot.live
}
