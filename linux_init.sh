sudo apt update
sudo apt install -y git
sudo apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential # from pico docs
#sudo apt install gcc g++


git submodule update --init --recommend-shallow # updates rm_pico_dev
cd rm_pico_dev
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib and rm_pico_dev/picotool
cd lib/pico-sdk/
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib/pico-sdk/lib


# building picotool
sudo apt install libusb-1.0-0-dev
cd ../../picotool
mkdir build
cd build
export PICO_SDK_PATH=../lib/pico-sdk/
cmake ../
make