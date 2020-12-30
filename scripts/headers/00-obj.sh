#!/usr/bin/env bash

obj_properties=()

obj.property()
{
    if [ "$2" == "=" ]
    then
        obj_properties[$1]=$3
    else
        printf "${obj_properties[$1]}"
    fi
}
