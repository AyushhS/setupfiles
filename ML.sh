#!/bin/bash

# This script setups all the tools needed for machine learning. 

source config

echo "Starting ML Setup..."
sleep 2

# Intializer of script
if [[ $1 == 'with_sudo' ]]; then
    MANUAL_SETUP=$2
else
    echo "Provide Super User privilages - "
    sudo true
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
fi

# installs python12
wget https://www.python.org/ftp/python/3.12.4/Python-3.12.4.tgz
tar -xf Python-3.12.4.tgz
cd Python-3.12.4
./configure --enable-optimizations
sudo make install
cd ..


# installs pip
sudo apt install python3-pip -y
sudo apt-get install python-is-python3
pip3 install -U --user pip

# makes a ML virtual environment
python3 -m venv ML
source Ml/bin/activate

# Python Libraries
pip3 install numpy pandas scikit-learn matplotlib

# CUDA
echo ""
if [[ $MANUAL_SETUP == 1 ]]; then
    for (( ; ; )) 
    do 
        read -p "CUDA Version (11/12) [If you do not have CUDA enabled GPU then set the value to 0]: " CUDA_VERSION
        if  [[ $CUDA_VERSION == 11 ]] || [[ $CUDA_VERSION == 12 ]] || [[ $CUDA_VERSION == 0 ]]; then
            break
        else
            echo "Try again with the correct options!"
        fi 
    done
fi

# Pytorch setup
echo ""
if [[ $MANUAL_SETUP == 1 ]]; then
    for (( ; ; )) 
    do 
        read -p "Pytorch setup? (Y/N): " confirm
        if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
            sudo ./pytorch.sh $CUDA_VERSION dependent 
            break
        elif [[$confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
            break
        else
            echo "Try again with the correct options!"
        fi 
    done
else
    if [[ $PYTORCH_SETUP == 1 ]]; then
        sudo ./pytorch.sh $CUDA_VERSION dependent
    fi
fi


# Tensorflow setup 
if [[ $MANUAL_SETUP == 1 ]]; then
    for (( ; ; )) 
    do 
        read -p "Tensorflow setup? (Y/N): " confirm
        if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
            ./tensorflow.sh $CUDA_VERSION dependent
            break
        elif [[$confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
            break
        else 
            echo "Try again with the correct options!"
        fi 
    done
else 
    if [[ $TENSORFLOW_SETUP == 1 ]]; then
        ./tensorflow.sh $CUDA_VERSION dependent
    fi 
fi

function miniconda_install {
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
}

# miniconda setup
if [[ $MANUAL_SETUP == 1 ]]; then
    for (( ; ; )) 
    do 
        read -p "Miniconda setup? (Y/N): " confirm
        if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
            miniconda_install
            break
        elif [[$confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
            break
        else 
            echo "Try again with the correct options!"
        fi 
    done
else 
    if [[ $MINICONDA_SETUP == 1 ]]; then
        miniconda_install
    fi 
fi

deactivate