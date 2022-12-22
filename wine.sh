#!/bin/sh
rpm-ostree install wine vulkan-loader.i686
rpm-ostree apply-live --allow-replacement
#notify-send "wine has been installed and configured in the system, please reboot"
