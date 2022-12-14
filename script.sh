#!/bin/sh
## System
sudo sh ./debloat.sh
sudo dnf upgrade -y
notify-send "upgraded the system"

sh manuel.sh
notify-send "manual is setup"

sudo sh ./swap.sh
notify-send "ran the swap script"

## Applications
sh ./appimage.sh
notify-send "appimage launcher is setup"

#sudo sh ./wine.sh
#wine a
sudo sh flatpak.sh
#flatpak run org.winehq.Wine a
notify-send "flatpak is setup"
sudo sh wine.sh
wine a
notify-send "wine is setup"

## cursor fix
sh ./cursorfix.sh
sudo sh ./cursorfixsu.sh
notify-send "cursorfix is all setup"

## branding
sudo sh ./brandingsu.sh
sh ./branding.sh
notify-send "all the branding has been applied"

## fonts
sh ./fonts.sh
sudo sh ./fontssu.sh
notify-send "fonts have been setup, waiting for manual change"

kwrite ./tasks.txt && cd .. && rm -rf branding && echo " " > ~/.bash_history
