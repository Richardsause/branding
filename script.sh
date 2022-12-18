#!/bin/sh
## System
sudo rpm-ostree upgrade
notify-send "upgraded the system via rpm-ostree"

sudo sh ./swap.sh
notify-send "ran the swap script"

## Applications
sudo sh ./wine.sh
sudo sh flatpak.sh
notify-send "wine and flatpak are all setup"

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

kwrite ./tasks.txt && cd .. && rm -rf branding
