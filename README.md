PowerBlockling Driver
=================

This is the driver for the petrockblock.com [PowerBlockling](https://blog.petrockblock.com/powerblockling/), 
which is an extension board for the Raspberry Pi (TM). The driver itself is denoted as _powerblockling_ in the following. The 
driver provides a service for interacting with the power button signal as well as driving the optionally attached LED.


## Installation

There comes an installation script with this reposity that does all the steps described below: `install.sh` This script 
compiles the driver, installs the binary and configuration files, and installs the PowerBlockling service. 

To run the quick installation, you just need to call this one line from the Raspbian console

```bash
wget -O - https://raw.githubusercontent.com/petrockblog/PowerBlockling/master/install.sh | sudo bash
```

To uninstall the service you can simply call `sudo ./uninstall.sh` from within the `PowerBlock` directory.


<br><br>
__Have fun!__

-Florian [petrockblock.com](http://blog.petrockblock.com)
