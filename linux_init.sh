sudo apt update
sudo apt install -y git
# from pico docs
sudo apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential \
    gdb-multiarch libstdc++-arm-none-eabi-newlib doxygen ninja-build
#sudo apt install gcc g++

OUTDIR="$(pwd)"


git submodule update --init --recommend-shallow # updates rm_pico_dev
cd rm_pico_dev
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib and rm_pico_dev/picotool
cd lib/pico-sdk/
SDK_PATH=$(pwd)
echo "export PICO_SDK_PATH=$SDK_PATH" >> ~/.bashrc # adding picosdk to path
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib/pico-sdk/lib


cd $OUTDIR
# building picotool (from pico tool github)
git clone https://github.com/raspberrypi/picotool.git
cd picotool
sudo apt install -y pkg-config libusb-1.0-0-dev
mkdir build
cd build
export PICO_SDK_PATH=$SDK_PATH
cmake ../
make -j4

echo "Installing picotool to /usr/local/bin/picotool"
sudo cp picotool /usr/local/bin/
cd ..
sudo cp udev/99-picotool.rules /etc/udev/rules.d/ # run picotool without sudo
cd ..
rm -rf picotool/

# auto open in vscode 
cd $OUTDIR
# checking if vscode is installed
if command -v code &> /dev/null
then
    echo "vscode is installed, opining..."
    code $OUTDIR
    exit
fi
