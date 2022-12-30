#!/bin/sh
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
sudo dnf in -y ./appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
mkdir -p ~/.config
mkdir -p ~/Applications
cp appimagelauncher.cfg ~/.config/
