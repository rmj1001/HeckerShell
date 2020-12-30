#!/usr/bin/env bash

# Declare a class
class ()
{
    . <(sed "s|obj|$1|g" $SCRIPTS/libs/class/obj.sh)
}
