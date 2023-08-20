# sample_rm_pico_app

This repo is a template repo to set up develpment for [pi pico](https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html) to work in the [robomasters](https://www.robomaster.com/en-US) competition.

It uses the [rm_pico_dev](https://github.com/agmui/rm_pico_dev) library

# Setup Guide

## Linux(ubuntu)

This will take a while and needs sudo

### WARNING DO NOT CLONE OR UPDATE RECURSIVELY

<details>
<summary>why tho?</summary>
There are some submodules that may go on for a while (like tinyusb) and I highly
recommend you don't need to get them.
If you want to see what submodules I update just look in `linux_init.sh`

</details>

```bash
git clone https://github.com/agmui/sample_rm_pico_app.git
cd sample_rm_pico_app
./linux_init.sh && source ~/.bashrc
```

Next install: [vscode](https://code.visualstudio.com/Download)  
go on to [vscode section](#vscode-extensions)

## Windows


Next install: [vscode](https://code.visualstudio.com/Download)  
go on to [vscode section](#vscode-extensions)

### WSL

follow the linux guide but currently some methods do not work (also ur kinda on ur own hehe)

TODO: make separate guide for vscode section

## Mac

<details>
<summary>might not work lol</summary>

`brew install libusb pkg-config`

Next install: [vscode](https://code.visualstudio.com/Download)  
go on to [vscode section](#vscode-extensions)
</details>

## vscode extensions

install vscode  
Have vscode open this repo
When first opining vscode should ask you to install the plugins  
![install plugins](pics/install_plugins.png)

If not just type `@recommended` here  
![recommened](pics/recommended.png)

## Uploading

Make sure the pico is pluged in

#### Method 1

> Note: This method assumes you installed all the recommend plugins from the [vscode section](#vscode-extensions)  

Step1:  
select kit
![no kit selected button](pics/noKitBtn.png)
![selecting arm kit](pics/armKit.png)

Step2:  
press `CTRL + SHIFT + B`  

Step3:
select the usb port the pico is plugged in it should look like this:  
![serial monitor](pics/serial_monitor.png)  
then hit start monitoring

<details>
<summary>if no show up</summary>
is the pico plugged in  
if not re press `CTRL + SHIFT + B`
</details>

### BIG NOTE: If the pico bricks you cant just use `CTRL + SHIFT + B` you have to reset it or do Method 2

#### Method 2

```bash
mkdir build
cd build
cmake ..
make -j4
picotool load -f pico_app.uf2
```

#### If all else fails

<details>
<summary>Method 3</summary>

```bash
mkdir build
cd build
cmake ..
make -j4
```

unplug the pico  
Hold the bootsel button on the pico  
![bootsel](pics/bootsel.png)  
while still holding the button plug the pico back in

A usb stick should pop up in your file explorer  
TODO: add pic

drag and drop the `pico_app.u2f` file in the build folder
![copying over uf2 file](pics/copy_uf2_over.png)

</details>

## Debugging

Wire up two picos like this  
![picoprobe wiring](pic/../pics/picoprobe_wiring.png)

upload this file
[pico-debug.uf2](https://github.com/essele/pico_debug/releases/tag/v0.3)
to the left pico in the picture using any method from [above](#uploading)

Next select the right debugger and run  
![pico debug](pics/pico_debug.png)

You can also open serial monitor if you want bc uart is passed through

> side note: I don't use picoprobe or openocd. I use this for those who care
[pico_debug](https://github.com/essele/pico_debug/tree/v0.3)

## Running in [Wokwi](https://wokwi.com/) 👀

No pico no problem! We can just simulate it 🤯

### Step1

press `CTRL + SHIFT + P` and type `Wokwi: Request a new License`
![wokwi license](pics/wokwi_license.png)

its going to ask to open a webpage  
![wokwi trust open webpage](pics/wokwi_license_open.png)

click get you license and make an account  
![wokwi get license](pics/wokwi_get_license.png)

this should pop up when it works  
![wokwi got license](pics/license_worked.png)

### Step2

do `Ctrl + SHIFT + P` again  
type `Wokwi: Start Simulator and Wait for Debugger`
![wokwi debugging](pics/wokwi_debug_prompt.png)  

<details>
<summary>Select a Kit?</summary>

if it asks to select kit  
choose arm as kit  
![selecting kit for wokwi debug](pics/wokwi_select_kit.png)

</details>  

### Step3

Next select the right debugger and run  
![debug setup](pics/wokwi_debug_setup.png)

then open up `main.cpp` to add breakpoints

to set up any wiring go here and copy the `diagram.json` when done [pico wokwi](https://wokwi.com/projects/new/pi-pico)

## Building

Method 1:  
Just press `f7` if you installed all [plugins](#vscode-extensions)

Method 2:

```bash
mkdir build
cd build
cmake ..
make -j4
```
