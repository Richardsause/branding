#!/bin/sh
## System
sudo rpm-ostree upgrade
sudo sh ./swap.sh
notify-send "upgraded the system via rpm-ostree"

## Applications
sudo sh ./wine.sh
sudo sh flatpak.sh

## cursor fix
sh ./cursorfix.sh
sudo sh ./cursorfixsu.sh

## branding
sudo sh ./brandingsu.sh
sh ./branding.sh

## fonts
sh ./fonts.sh

kwrite ./tasks.txt
