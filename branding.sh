#!/bin/sh
## /home/richard/
# desktop theme
mkdir -p ~/.local/share/plasma/desktoptheme
cp -r RTT ~/.local/share/plasma/desktoptheme/
plasma-apply-desktoptheme RTT

# color sheme
mkdir -p ~/.local/share/color-schemes/
cp rrt.colors ~/.local/share/color-schemes/
plasma-apply-colorscheme rrt

# wallpaper
mkdir -p ~/.local/share/wallpapers
cp -r wallpaper.png ~/.local/share/wallpapers
plasma-apply-wallpaperimage "//home/cliente/.local/share/wallpapers/wallpaper.png"
notify-send "branding applied to home"

# trashbin on the desktop
cp trash.desktop ~/"Área de trabalho"/
notify-send "trashbin added to the desktop on home"
