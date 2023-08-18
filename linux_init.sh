sudo apt install -y  cmake git
cd rm_pico_dev
git submodule update --init --recommend-shallow 
cd lib/pico-sdk/
git submodule update --init --recommend-shallow
