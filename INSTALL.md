# Device Driver Install Manual

## Prerequisites

- Kernel Source
- dtc (Device Tree Compiler)
- GCC (version matching compiled linux kernel image)

### Getting dtc (Device Tree Compiler) package

Install dtc by package system.

    sudo apt-get install device-tree-compiler

### Install bc command

If bc is not installed, must install bc.

    sudo apt-get install bc

### Getting GCC

Install GCC by package system.

    sudo apt-get install gcc

Check GCC version

    gcc --version

### Getting Kernel Source

See: https://www.raspberrypi.com/documentation/computers/linux_kernel.html#building-the-kernel-locally

Clone next to this folder. Follow instructions for building and installing the kernel. Reboot.

## Driver Install

### 1. Pull driver source files

    git clone https://github.com/audiophonics/I-Sabre-K2M

    Check out 6.6.y branch.

### 2. Build & Install driver & dtb (device tree blob)

    make
    sudo make modules_install
    make dtbs
    sudo make install_dtbo

### 3. Change /boot/config.txt

Add following lines.

    dtoverlay=i-sabre-k2m
    dtparam=i2c_arm=on

### 4. Reboot Raspberry Pi

### 5. Check driver is normaly installed

Use aplay -l command to check audio card is added.

    aplay -l

Installed audio card is follows.

    card xxx: DAC [I-Sabre K2M DAC], device 0: I-Sabre K2M DAC i-sabre-k2m-dai-0 []
