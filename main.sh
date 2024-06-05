#!/bin/bash

source ./welcome.sh

# welcome script and confirmation of proceeding with the setup
welcome
START=$?
if [[ $START == 0 ]]; then
    exit
fi

# If manual setup is required or config
MANUAL_SETUP=0
for (( ; ; )) 
do 
    read -p "Manual setup? [This will ask every time if a utility needs to be installed. If No, the script use config file] (Y/N): " confirm
    if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
        MANUAL_SETUP=1
        break
    elif [[ $confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
        source config
        break
    else 
        echo "Try again with the correct options!"
    fi 
done 

# # Basic setup
echo ""
echo ""
echo "Starting basic setup..."
echo ""
echo ""
sleep 2
echo "Provide Super User privilages - "
sudo true

# basic ubuntu packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install curl -y
sudo apt-get install wget gpg -y

# Git setup
sudo apt-get install git -y 
git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

# ML setup
if [[ $MANUAL_SETUP == 1 ]]; then
    for (( ; ; )) 
    do 
        read -p "ML setup? [includes python libraries for ML, tensorflow, pytorch and miniconda] (Y/N): " confirm
        if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
            sudo ./ML.sh with_sudo $MANUAL_SETUP
            break
        elif [[ $confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
            break
        else
            echo "Try again with the correct options!"
        fi 
    done
else
    if [[ $ML_SETUP == 1 ]]; then
        sudo ./ML.sh with_sudo $MANUAL_SETUP
    fi
fi

NOTE - completed till here.

echo ""
echo ""
echo "Starting installation of applications..."
echo ""
echo ""
sleep 2
./applications.sh with_sudo $MANUAL_SETUP
