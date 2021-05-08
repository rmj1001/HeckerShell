#!/usr/bin/env zsh

############################## SHELL FUNCTIONS ##############################

### Print text to STDOUT without 'echo'
# usage: PRINT "<text>"
PRINT() { printf "%b\n" "${@}" }

### Print text without newline
# usage: NPRINT "<text>"
NPRINT() { printf "%b" "${@}" }

### Run programs silently in the background
# usage: silentrun <program> [args?]
SILENTRUN() { $@ 2>&1 > /dev/null; return $? }

### Run programs in the background in disowned processes
# usage: ASYNC '<commands>'
ASYNC() { nohup $@ > /dev/null 2>&1 & }

### Make all text uppercase
# usage: UPPERCASE "text" -> "TEXT"
UPPERCASE() { NPRINT "$1" | tr '[:lower:]' '[:upper:]' }

### Make all text lowercase
# usage: LOWERCASE "TEXT" -> "text"
LOWERCASE() { NPRINT "$1" | tr '[:upper:]' '[:lower:]' }

### Random number generator
# usage: random <number?>
random() { NPRINT "$(( 1 + ${RANDOM} % ${1:-100} ))" }

### Message of the Day
# usage: motd
motd ()
{
    local motdFile="${HOME}/.zsh/.motd.txt"

    [[ -f "${motdFile}" ]] || return 0

    [[ "$1" == '--lolcat' ]] && SILENTRUN command -v lolcat && lolcat ${motdFile} && return 0
    [[ "$1" == '--edit' ]] && ${EDITOR} ${motdFile} && return 0

    cat ${motdFile}
}

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

# Replace 'which'
alias which="command -v"

# Replaces 'cat' with 'batcat' (Rust rewrite)
if SILENTRUN command -v batcat; then
	alias bat="/bin/batcat"
	alias cat="bat -p"
fi

# Replaces 'cat' with 'bat' on Arch (Rust rewrite)
if SILENTRUN command -v bat && SILENTRUN command -v pacman; then
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

# Pipewire
alias restart-pipewire="systemctl restart --user pipewire; systemctl restart --user pipewire-pulse; systemctl restart --user bluetooth"

# Default apps
alias terminal="${TERMINAL}"
alias browser="${BROWSER}"
alias auth="${AUTH}"

########################## CURL APPS ##########################

### CURL APPS HELP
# usage: curlapps
curlapps()
{
    PRINT "cheat \t\t [command]"
    PRINT "weather"
    PRINT "qrcode \t\t [url]"
    PRINT "dict \t\t [word]"
    PRINT "rate \t\t [emtpy or currency]"
    PRINT "getnews \t [query]"
    PRINT "parrot"
}

### CHEAT PAGES
# usage: cheat <command>
cheatsh()
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
