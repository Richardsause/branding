#!/bin/sh
### System upgrade
sudo rpm-ostree upgrade
notify-send "upgraded the system via rpm-ostree"

### Wine
sudo rpm-ostree install wine vulkan-loader.i686
notify-send "wine has been installed and configured in the system, please reboot"

### Cursor fix
## /etc/skel
sudo mkdir -p /etc/skel/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > /etc/skel/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors /etc/skel/.local/share/icons/default/
notify-send "default cursor theme applied to skel"

## /root
sudo mkdir -p /root/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > /root/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors /root/.local/share/icons/default/
notify-send "default cursor theme applied to root"

## /home/cliente
mkdir -p ~/.local/share/icons/default
sudo echo "[Icon Theme]
Inherits=breeze_cursors" > ~/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors ~/.local/share/icons/default/
plasma-apply-cursortheme default
notify-send "default cursor theme applied to home"

### Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-delete fedora
flatpak install org.gtk.Gtk3theme.Breeze -y
sudo flatpak override --env GTK_THEME=Breeze
notify-send "flathub remote added"

## Flatpak patch
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
notify-send "flatpak fixed"

## Applications
flatpak install libreoffice gimp kate chromium -y
notify-send "applications installed"

### Run the swap script
sudo sh ./swap.sh
notify-send "ran the swap script"

### Apply the branding
## /etc/skel
# desktop theme
sudo mkdir -p /etc/skel/.local/share/plasma/desktoptheme/
sudo cp -r RTT /etc/skel/.local/share/plasma/desktoptheme/

# color sheme
sudo mkdir -p /etc/skel/.local/share/color-schemes/
sudo cp rrt.colors /etc/skel/.local/share/color-schemes/

# wallpaper
sudo mkdir -p /etc/skel/.local/share/wallpapers
sudo cp -r wallpaper.png /etc/skel/.local/share/wallpapers
notify-send "branding copied over to skel"

# trashbin on the desktop
sudo mkdir -p /etc/skel/"Área de trabalho"/
sudo cp trash.desktop /etc/skel/"Área de trabalho"/
notify-send "trashbin added to the desktop on /etc/skel"

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

notify-send "everything left to you is to fix the desktop"
