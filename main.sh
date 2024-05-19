#!/bin/bash

# Basic setup
echo "Starting basic setup..."
sleep 2
echo "Provide Super User privilages - "
sudo true

# basic ubuntu packages
sudo apt-get update -y
sudo apt-get upgrade -y


# installs pip
sudo apt install python3-pip -y
pip3 install -U --user pip



# Tensorflow setup 
for (( ; ; )) 
do 
    read -p "Tensorflow setup? (Y/N): " confirm
    if  [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] then
        ./tensorflow.sh without_sudo
        break
    else 
        echo "Try again with the correct options!"
    fi 
done

# Python Packages
pip3 install numpy pandas scikit-learn matplotlib torch torchvision torchaudio



echo "yes"