#!/bin/sh
flatpak install org.winehq.Wine/x86_64/stable-22.08 org.winehq.Wine.gecko/x86_64/stable-22.08 org.winehq.Wine.mono/x86_64/stable-22.08 -y
#notify-send "wine has been installed and configured in the system, please reboot"
