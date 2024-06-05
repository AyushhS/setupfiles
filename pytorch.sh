#!/bin/bash

# This script sets up pytorch.

source config

function pytorch_setup {
    if [[ $1 == 11 ]]; then
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
    elif [[ $1 == 12 ]]; then
        pip3 install torch torchvision torchaudio
    else 
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
    fi
}

if [[ $2 == 'dependent' ]]; then
    pytorch_setup $1
else 
    read -p "CUDA Version (11/12) [If you do not have CUDA enabled GPU then set the value to 0]: " CUDA_VERSION
    pytorch_setup $CUDA_VERSION
fi
