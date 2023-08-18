sudo apt install -y  cmake git
cd rm_pico_dev
echo yes | git submodule update --init --recommend-shallow
cd lib/pico-sdk/
echo yes | git submodule update --init --recommend-shallow
