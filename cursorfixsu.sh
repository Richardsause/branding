#!/bin/sh
## skel
mkdir -p /etc/skel/.local/share/icons/default
echo "[Icon Theme]
Inherits=breeze_cursors" > /etc/skel/.local/share/icons/default/index.theme
ln -s /usr/share/icons/breeze_cursors/cursors /etc/skel/.local/share/icons/default/
#notify-send "cursor fix applied to skel"

## root
mkdir -p /root/.local/share/icons/default
echo "[Icon Theme]
Inherits=breeze_cursors" > /root/.local/share/icons/default/index.theme
ln -s /usr/share/icons/breeze_cursors/cursors /root/.local/share/icons/default/
#notify-send "cursor fix applied to root"
