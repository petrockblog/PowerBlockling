#!/bin/bash

function installService() {
    grep -qxF 'enable_uart=1' /boot/config.txt || echo 'enable_uart=1' >> /boot/config.txt
    grep -qxF 'dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1' /boot/config.txt || echo 'dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1' >> /boot/config.txt

    echo "Installation of PowerBlockling service done. Please REBOOT to activate changes."
}

# ----------------------------------

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo from the user you want to install for. Try 'sudo $0'"
    exit 1
fi

installService
