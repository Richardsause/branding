#!/bin/sh
## home
mkdir -p ~/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > ~/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors ~/.local/share/icons/default/
mkdir ~/.icons
cp ~/.local/share/icons/default -r ~/.icons/
plasma-apply-cursortheme default
#notify-send "cursor fix applied to current user"
