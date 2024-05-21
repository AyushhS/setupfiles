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

# Intializer of script
if [[ $1 == 'with_sudo' ]] then
    MANUAL_SETUP=$2
else
    echo "Provide Super User privilages - "
    sudo true
    MANUAL_SETUP=0
    for (( ; ; )) 
    do 
        read -p "Manual setup? [This will ask every time if a utility needs to be installed. If No, the script use config file] (Y/N): " confirm
        if  [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] then
            MANUAL_SETUP=1
            break
        elif [[ $confirm == [Nn] || $confirm == [Nn][Oo] ]] then
            source config
            break
        else 
            echo "Try again with the correct options!"
        fi 
    done 
fi

application "Microsoft Teams" $MICROSOFT_TEAMS $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install teams-for-linux; fi

application "Chrome" $CHROME $MANUAL_SETUP
if [[ $? == 1 ]] then 
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt -f install ./google-chrome-stable_current_amd64.deb
fi

application "Spotify" $SPOTIFY $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install spotify; fi

application "Microsoft To Do" $MICROSOFT_To_DO $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install microsoft-todo-unofficial; fi

application "VLC Media Player" $VLC $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install vlc; fi

# TODO - have to check if snap is more stable or deb file
application "Discord" $DISCORD $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install discord; fi

#TODO - have to check if snap is more stable than deb
application "VS Code" $VS_CODE $MANUAL_SETUP
if [[ $? == 1 ]] then sudo snap install --classic code; fi

application "Deluge" $DELUGE $MANUAL_SETUP
if [[ $? == 1 ]] then sudo apt-get install deluge; fi

application "Brave" $BRAVE $MANUAL_SETUP
if [[ $? == 1 ]] then 
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
fi

# TODO - brave setup