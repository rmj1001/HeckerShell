#!/usr/bin/env bash

##############################################
#   Author(s): name <email@domain.com>
#   Plugin: curlapps
#   Version: 1.0
#
#   Usage: curlapps, etc.
#
#   Description: Common curl applications packaged in shell functions
#
##############################################

### CURL APPS HELP
# Usage: curlapps
function curlapps() {
    PRINT "cheat \t\t [command]"
    PRINT "weather"
    PRINT "qrcode \t\t [url]"
    PRINT "dict \t\t [word]"
    PRINT "rate \t\t [emtpy or currency]"
    PRINT "getnews \t [query]"
    PRINT "parrot"
}

### CHEAT PAGES
# Usage: cheat <command>
function cheatsh() {
    curl "cheat.sh/${1}"
}

### WEATHER
# Usage: weather
function weather() {
    curl wttr.in
}

### QR CODE CREATOR
# Usage: qrcode <link>
function qrcode() {
    curl "qrenco.de/${1}"
}

### DICTIONARY
# Usage: dict <word>
function dict() {
    curl "dict://dict.org/d:${1}"
}

### CRYTPOCURRENCY RATES
# Usage: rate <cryptocurrency symbol>
function rate() {
    curl "rate.sx/${1}"
}

### URL SHORTENER
# Usage: urlshorten <link>
function urlshorten() {
    curl -F "shorten=${1}" https://0x0.st
}

### NEWS READER
# Usage: getnews <topic>
function getnews() {
    curl "getnews.tech/${1}"
}

### PARROT IN TERMINAL
# Usage: parrot
function parrot() {
    curl parrot.live
}
