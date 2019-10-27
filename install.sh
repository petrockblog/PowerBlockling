#!/bin/bash

function prepare() {
    # check, if sudo is used
    if [[ "$(id -u)" -ne 0 ]]; then
        echo "Script must be run under sudo from the user you want to install for. Try 'sudo $0'"
        exit 1
    fi

    # ensure that all needed OS packages are installed
    apt-get install -y git || (c=$?; echo "Error during installation of APT packages"; (exit $c))

    # ensure that we are within the PowerBlock directory
    currentDirectory=${PWD##*/}
    if [[ $currentDirectory != "PowerBlockling" ]]; then
        if [[ -d PowerBlockling ]]; then
            rm -rf PowerBlockling
        fi
        git clone --recursive --depth=1 git://github.com/petrockblog/PowerBlockling
        cd PowerBlockling
    fi

    # ensure that no old instance of the driver is running
    isOldServiceRunning=$(ps -ef | grep powerblockling | grep -v grep)
    if [[ ! -z $isOldServiceRunning ]]; then
        make uninstallservice
    fi 
}

function installFiles() {
    install --mode 0755 scripts/powerblocklingservice /usr/bin/powerblocklingservice
}

function installService() {
    grep -qxF 'enable_uart=1' /boot/config.txt || echo 'enable_uart=1' >> /boot/config.txt

    install -m 0755 scripts/powerblockling /etc/init.d
    update-rc.d powerblockling defaults
    /etc/init.d/powerblockling start
    echo "Installation of PowerBlockling service done."
}

# ----------------------------------

prepare
installFiles
installService

sleep 3


# sanity checks
# check that the binary is installed
if [[ ! -f /usr/bin/powerblock ]]; then
    echo "[ERROR] The PowerBlockling driver binary is not installed"
else
    echo "[SUCCESS] The PowerBlockling driver binary is installed"
fi

# check that the service is running
isServiceRunning=$(ps -ef | grep powerblockling | grep -v grep)
if [[ ! -z $isServiceRunning ]]; then
    echo "[SUCCESS] The PowerBlockling service is running"
else
    echo "[ERROR] The PowerBlockling service is not running"
fi 
