#!/usr/bin/env bash

#
# Plugin Name: curlapps
# Description: Common curl applications packaged in ZSH functions
# Author(s): RMCJ <rmichael1001@gmail.com>
#

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
