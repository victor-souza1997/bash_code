#!/bin/bash

# Check if fastboot command exists
if ! command -v fastboot &> /dev/null; then
    echo "fastboot command not found. Installing android-tools-adb and android-tools-fastboot..."
    sudo apt update
    sudo apt install android-tools-adb android-tools-fastboot
fi

# Take the name of the product as input
product_name="$1"

# Change directory to the desired location
cd Android/aosp/out/target/product/"$product_name"

# Define the fastboot command
fastboot_cmd="fastboot"

# Check if running with sudo
if [[ $EUID -ne 0 ]]; then
    fastboot_cmd="sudo fastboot"
fi

# Flash boot.img
$fastboot_cmd flash boot boot.img

# Flash super.img
$fastboot_cmd flash super super.img

# Flash cache.img
$fastboot_cmd flash cache cache.img

# Flash userdata.img
$fastboot_cmd flash userdata userdata.img

# Flash recovery.img
$fastboot_cmd flash recovery recovery.img

# Flash dtbo-unsigned.img
$fastboot_cmd flash dtbo dtbo-unsigned.img

# Reboot the device
$fastboot_cmd reboot

