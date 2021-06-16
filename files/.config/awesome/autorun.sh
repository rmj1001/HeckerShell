#!/usr/bin/env bash

function run () {
    if ! pgrep -f $1 ;
    then
        $@&
    fi
}

### AUTOSTART APPS ###
run plank
