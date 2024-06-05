#!/bin/bash

echo ""
echo "SETUP FOR UBUNTU"
echo ""
echo "This Script will setup various ML tools and other softwares automatically. Include the softwares you want to install in the config.sh script."
function welcome {
    for (( ; ; ))
    do
        read -p "Start setup? (Y/N): " confirm
        if  [[ $confirm == [yY] ]] || [[ $confirm == [yY][eE][sS] ]]; then
            return 1
        elif [[ $confirm == [Nn] ]] || [[ $confirm == [Nn][Oo] ]]; then
            return 0
        else
            echo "Try again with the correct options!"
        fi
    done
}
