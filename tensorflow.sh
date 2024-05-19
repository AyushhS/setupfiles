#!/bin/bash

source /etc/os-release

# Starting setup
echo "Starting Tensorflow GPU installation and setup..."
sleep 2

# Super User privilages
if [[ "$@" == "without_sudo" ]] then
    continue
else
    echo "Provide Super User privilages - "
    sudo true
fi

# installing nvidia drivers
echo "Installing NVIDIA drivers..."
echo ""
sleep 2
sudo ubuntu-drivers install

# installing cuda toolkit
echo "Installing CUDA Toolkit"
echo ""
sleep 2
wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_550.54.15_linux.run
sudo sh cuda_12.4.1_550.54.15_linux.run

# installing cudnn library
echo "Installing CuDNN library"
echo ""
sleep 2
UBUNTU_VERSION=${VERSION_ID:0:2}${VERSION_ID:3:5}
wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu$UBUNTU_VERSION-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
for (( ; ; )) 
do 
    read -p "Which CUDA version to install? (11/12): " CUDA_VERSION
    if  [[ $CUDA_VERSION == 11 || $CUDA_VERSION == 12 ]] then
        break
    else 
        echo "Try again with the correct options!"
    fi 
done
sudo apt-get -y install cudnn-cuda-$CUDA_VERSION

# installing tensorflow
pip install tensorflow[and-cuda]

# testing 
GPUs=$(python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))")
if [[ GPUs == '[]' ]] then
    echo "Install Unsucessful. Check the script for errors."
else 
    echo "Tensorflow installed Successfully with $GPUs initialized."
fi