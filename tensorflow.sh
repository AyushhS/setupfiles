#!/bin/bash

# This script sets up tensorflow with GPU support. 

# NOTE - include tf cpu too. make it indepedent with the CUDA version. pytorch one too.

source /etc/os-release
source config

if [[ $2 == "dependent" ]]; then
    CUDA_VERSION=$1
else 
    read -p "CUDA Version (11/12) [If you do not have CUDA enabled GPU then set the value to 0]: " CUDA_VERSION
    echo "Provide Super User privilages - "
    sudo true
fi

# if only tensorflow cpu needed
if [[ $CUDA_VERSION == 0 ]]; then
    python3 -m pip install tensorflow
    exit
fi

# Starting setup
echo ""
echo ""
echo "Starting Tensorflow GPU installation and setup..."
echo ""
echo ""
sleep 2

# installing nvidia drivers
echo ""
echo ""
echo "Installing NVIDIA drivers..."
echo ""
echo ""
sleep 2
sudo ubuntu-drivers install



# installing cuda 
echo ""
echo ""
echo "Installing CUDA drivers..."
echo ""
echo ""
sudo apt install nvidia-cuda-toolkit -y

# installing cuda toolkit
# echo "Installing CUDA Toolkit"
# echo ""
# sleep 2
# wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_550.54.15_linux.run
# sudo sh cuda_12.4.1_550.54.15_linux.run

# # installing cudnn library
# echo "Installing CuDNN library"
# echo ""
# sleep 2
# UBUNTU_VERSION=${VERSION_ID:0:2}${VERSION_ID:3:5}
# wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1_1.0-1_amd64.deb
# sudo dpkg -i cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1_1.0-1_amd64.deb
# sudo cp /var/cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get -y install cudnn-cuda-$CUDA_VERSION

# installing tensorflow
echo ""
echo ""
echo "Installing Tensorflow..."
echo ""
echo ""
pip install tensorflow[and-cuda]

# testing 
GPUs=$(python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))")
if [[ GPUs == '[]' ]]; then
    echo "Install Unsucessful. Check the script for errors."
else 
    echo "Tensorflow installed Successfully with $GPUs initialized."
fi
