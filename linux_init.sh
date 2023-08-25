#!/bin/bash
sudo apt update
echo ================================================================================================================================================================
sudo apt install -y git
# from pico docs
sudo apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential \
    gdb-multiarch libstdc++-arm-none-eabi-newlib doxygen ninja-build
#sudo apt install gcc g++
echo ================================================================================================================================================================

OUTDIR="$(pwd)"


git submodule update --init --recommend-shallow # updates rm_pico_dev
cd rm_pico_dev
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib and rm_pico_dev/picotool
cd lib/pico-sdk/
SDK_PATH=$(pwd)
echo "export PICO_SDK_PATH=$SDK_PATH" >> ~/.bashrc # adding picosdk to path
export PICO_SDK_PATH=$SDK_PATH
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib/pico-sdk/lib

echo ================================================================================================================================================================

cd $OUTDIR
# building picotool (from pico tool github)
git clone https://github.com/raspberrypi/picotool.git
cd picotool
sudo apt install -y pkg-config libusb-1.0-0-dev
mkdir build
cd build
cmake ../
make -j4

echo ================================================================================================================================================================ 

echo "Installing picotool to /usr/local/bin/picotool"
sudo cp picotool /usr/local/bin/
cd ..
sudo cp udev/99-picotool.rules /etc/udev/rules.d/ # run picotool without sudo
sudo udevadm control --reload # TODO: check if this works
cd ..
rm -rf picotool/


#==================== openocd====================
sudo apt install wget
# TODO somehow get the latest
wget https://github.com/earlephilhower/pico-quick-toolchain/releases/latest/download/x86_64-linux-gnu.openocd-8e3c38f78.230216.tar.gz
# https://github.com/earlephilhower/pico-quick-toolchain/releases/download/1.5.0-b/x86_64-linux-gnu.openocd-8e3c38f78.230216.tar.gz

tar -xvf x86_64-linux-gnu.openocd-8e3c38f78.230216.tar.gz
cd openocd/bin
$OPENOCD_PATH=$(pwd)
sudo ls -s $OPENOCD_PATH /usr/local/bin

# does not work because you can't update path(https://unix.stackexchange.com/questions/675050/update-bashrc-and-reload)
# auto open in vscode 
#cd $OUTDIR
# checking if vscode is installed
#if command -v code &> /dev/null
#then
#    echo "vscode is installed, opining..."
#    code $OUTDIR
#    exit
#fi
