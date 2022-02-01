#!/bin/bash

export PS1='\n$(write_lines)\n$(printf "%${COLUMNS}s\n" "$(date -u +"%m-%d-%Y %H:%M:%S")")[ ${USER}@${HOSTNAME} ] $(pwd) > '

# Plugins
export plugins=(
    backstreet
    curlapps
)
