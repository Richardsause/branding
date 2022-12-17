#!/bin/sh
### Cursor fix
## /etc/skel
sudo mkdir -p /etc/skel/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > /etc/skel/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors /etc/skel/.local/share/icons/default/

## /root
sudo mkdir -p /root/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > /root/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors /root/.local/share/icons/default/

## /home/cliente
mkdir -p ~/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > ~/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors ~/.local/share/icons/default/

### Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete fedora

## Applications
flatpak install libreoffice gimp kate chromium -y

### Run the swap script
sudo sh ./swap.sh
