# sample_rm_pico_app

This repo is a template repo to set up develpment for [pi pico](https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html) to work in the [robomasters](https://www.robomaster.com/en-US) competition.

It uses the [rm_pico_dev](https://github.com/agmui/rm_pico_dev) library

# Setup Guide

## Linux(ubuntu)

```
git clone https://github.com/agmui/sample_rm_pico_app.git
cd sample_rm_pico_app
bash linux_init.sh
```

Next install vscode and go on to the [vscode section](#vscode-extensions)

## Windows

dependency:
[libusb download](https://github.com/libusb/libusb/releases/latest)

Next install vscode and go on to the [vscode section](#vscode-extensions)

## vscode extensions

When first opining the project it should ask you to install the plugins

If not just type `@recommened` in the extentions window  
![recommened](pics/recommened.png)

These are recomened extensions to install.

## Uploading

Make sure the pico is pluged in

#### Method 1

Step1:  
select kit
TODO: add pic

Step2:  
press `f7`  

Step3:  
after finish building press `ctrl + shift + B`  

#### Method 2

```bash
mkdir build
cd build
cmake ..
make
picotool load -f pico_app.uf2
```

#### If all else fails

<details>
<summary>Method 3</summary>

```bash
mkdir build
cd build
cmake ..
make
```

unplug the pico  
Hold the bootsel button on the pico  
![bootsel](pics/bootsel.png)  
while still holding the button plug the pico back in

A usb stick should pop up in your file exploer  
TODO: add pic

drag and drop the `pico_app.u2f` file in the build folder

</details>

## Debugging

![picoprobe wiring](pic/../pics/picoprobe_wiring.png)
> sidenote: the debugger I use for those who care [pico_debug](https://github.com/essele/pico_debug/tree/v0.3)

## Running in Wokwi 👀

No pico no problem!

## Building

`f7`
