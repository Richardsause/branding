#!/bin/sh
## Flathub
flatpak remove --all -y
flatpak remote-delete fedora
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#notify-send "flathub has been added to the system and fedora removed"

## Breeze gtk
flatpak install org.gtk.Gtk3theme.Breeze -y
flatpak override --env GTK_THEME=Breeze
flatpak override --filesystem=xdg-config/gtk-3.0:ro
#notify-send "Breeze gtk3 is installed, and properly configured on the system"

## Applications
flatpak install org.libreoffice.LibreOffice org.kde.kate org.gimp.GIMP com.google.Chrome -y
flatpak install org.winehq.Wine/x86_64/stable-22.08 org.winehq.Wine.gecko/x86_64/stable-22.08 org.winehq.Wine.mono/x86_64/stable-22.08 -y
#notify-send "Flatpak applications are installed on the system"
