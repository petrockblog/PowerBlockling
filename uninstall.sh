#!/bin/bash

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo from the user you want to install for. Try 'sudo $0'"
    exit 1
fi

function uninstallFiles() {
    rm /usr/bin/powerblocklingservice
}

function uninstallService() {
    update-rc.d powerblockling remove
    rm /etc/init.d/powerblockling
    echo "PowerBlockling service uninstalled."
}

uninstallService
uninstallFiles

# check that the service is not running anymore
echo "[SUCCESS] The PowerBlockling service was successfully removed. Please reboot to finish the uninstallation."
