sudo apt install -y  git
sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential # from pico docs

git submodule update --init --recommend-shallow # updates rm_pico_dev
cd rm_pico_dev
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib
cd lib/pico-sdk/
git submodule update --init --recommend-shallow # updates rm_pico_dev/lib/pico-sdk/lib

