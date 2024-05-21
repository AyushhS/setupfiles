#!/bin/bash

source config

function application {
    if [[ $3 == 1 ]] then
        for (( ; ; )) 
        do 
            read -p "$1 installation? (Y/N): " confirm
            if  [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] then
                return 1 
                break
            elif [[ $confirm == [Nn] || $confirm == [Nn][Oo] ]] then
                return 0
                break
            else
                echo "Try again with the correct options!"
            fi 
        done
    else
        if [[ $2 == 1 ]] then
            return 1 
        fi
    fi
}

application "Microsoft Teams" $MICROSOFT_TEAMS $MANUAL_SETUP

echo $confirmation 