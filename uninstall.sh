#!/bin/bash

function uninstallService() {
	sed -i s/enable_uart=1//g /boot/config.txt
	sed -i s/dtoverlay=gpio-shutdown,gpio_pin=3,active_low=1//g /boot/config.txt
}

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo from the user you want to install for. Try 'sudo $0'"
    exit 1
fi

uninstallService

# check that the service is not running anymore
echo "[SUCCESS] The PowerBlockling service was successfully removed. Please REBOOT to finish the uninstallation."
