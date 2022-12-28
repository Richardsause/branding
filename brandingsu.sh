#!/bin/sh
## /etc/skel
# desktop theme
mkdir -p /etc/skel/.local/share/plasma/desktoptheme/
cp -r RTT /etc/skel/.local/share/plasma/desktoptheme/

# color sheme
mkdir -p /etc/skel/.local/share/color-schemes/
cp rrt.colors /etc/skel/.local/share/color-schemes/

# wallpaper
mkdir -p /etc/skel/.local/share/wallpapers
cp -r wallpaper.png /etc/skel/.local/share/wallpapers
#notify-send "branding copied over to skel"

# icon
sudo mkdir -p /etc/skel/.icons/
sudo cp start-here.svg /etc/skel/.icons/

# trashbin on the desktop
sudo mkdir -p /etc/skel/"Área de trabalho"/
sudo cp trash.desktop /etc/skel/"Área de trabalho"/
#notify-send "trashbin added to the desktop skel"
