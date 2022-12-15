#!/bin/sh

## DNF related stuff
sudo dnf up -y
echo "updated the system"

# Removing software
sudo dnf rm *akonadi* *akregator* *games* *krfb* *krdc* kwrite *konversation* *abrt* *firefox* *qt5-qdbusviewer* *power-profiles-daemon* -y
notify-send "removed all the bloat"

# Installing RPM fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-nonfree-release-tainted -y
sudo dnf upgrade -y --allowerasing
sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware" -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y --allowerasing
sudo dnf groupupdate sound-and-video -y --allowerasing
sudo dnf install intel-media-driver libva-intel-driver -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
notify-send "rpm fusion is fully setup"

# Installing some software
sudo dnf in chromium-freeworld thunderbird kgpg thermald plasma-browser-integration ktorrent -y
sudo systemctl enable thermald
echo "all the apps installed, and thermald has been enabled"

# wine
sudo dnf in wine vulkan-loader vulkan-loader.i686 -y
wine a
notify-send "wine setup and ready to use "

# hblock
sudo dnf in perl-Digest-SHA -y
curl -o /tmp/hblock 'https://raw.githubusercontent.com/hectorm/hblock/v3.4.0/hblock' \
  && echo '4031d86cd04fd7c6cb1b7e9acb1ffdbe9a3f84f693bfb287c68e1f1fa2c14c3b  /tmp/hblock' | shasum -c \
  && sudo mv /tmp/hblock /usr/local/bin/hblock \
  && sudo chown 0:0 /usr/local/bin/hblock \
  && sudo chmod 755 /usr/local/bin/hblock
sudo systemctl enable hblock.timer
notify-send "hblock is working"

# auto-cpufreq
sudo dnf copr enable gloriouseggroll/nobara-testing
sudo dnf upgrade -y
sudo dnf in auto-cpufreq -y
sudo systemctl enable auto-cpufreq
notify-send "auto-cpufreq is working"

## Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak --system remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-delete fedora
sudo flatpak update -y
sudo flatpak install org.gtk.Gtk3theme.Breeze -y
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
sudo flatpak override --filesystem=xdg-config/gtk-2.0:ro
notify-send "flatpak is configured"

## Fixing the system
sudo systemctl disable systemd-oomd
# swap
sudo chattr +C /swap/
sudo dd if=/dev/zero of=/swap/swapfile bs=1M count=4096 status=progress
sudo echo "/swap/swapfile none swap pri=0,discard 0 0" >> /etc/fstab
notify-send "swap is configured"

# grub
sudo curl https://raw.githubusercontent.com/Richardsause/branding/main/grub > /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
notify-send "grub has been configured"

# fixing up the cursors
mkdir ~/.local/share/icons
mkdir ~/.local/share/icons/default
echo "[Icon Theme]" > ~/.local/share/icons/default/index.theme
echo "Inherits=breeze_cursors" >> ~/.local/share/icons/default/index.theme
ln -s /usr/share/icons/breeze_cursors/cursors ~/.local/share/icons/default/
notify-send "default cursor theme added to plasma settings"

# fixing up the cursors on /etc/skel
sudo mkdir /etc/skel/.local/
sudo mkdir /etc/skel/.local/share
sudo mkdir /etc/skel/.local/share/icons
sudo mkdir /etc/skel/.local/share/icons/default
sudo echo "[Icon Theme]" > /etc/skel/.local/share/icons/default/index.theme
sudo echo "Inherits=breeze_cursors" >> /etc/skel/.local/share/icons/default/index.theme
sudo ln -s /usr/share/icons/breeze_cursors/cursors /etc/skel/.local/share/icons/default/
notify-send "default cursor theme added to plasma settings in /etc/skel"

cd ~/"Área de trabalho"
curl https://raw.githubusercontent.com/Richardsause/branding/main/trash%3A%E2%81%84.desktop > ~/"Área de trabalho"/"Lixeira.desktop"
echo "added trashbin file to the desktop"

## Branding
cd ~/Downloads
sudo dnf in git unzip curl -y
git clone https://github.com/Richardsause/branding
mv branding/* ~/Downloads
unzip brading.zip
sudo mv RTT /usr/share/plasma/desktoptheme/
sudo mv BreezeRRT.colors /usr/share/color-schemes/
sudo mv 169.png /usr/share/wallpapers/
chmod +x wallpaper.sh
./wallpaper.sh
plasma-apply-colorscheme BreezeRRT
/usr/lib/plasma-changeicons breeze-dark
plasma-apply-cursortheme default
notify-send "all the branding was downloaded and is waiting to be applied, doing a cleanup..."
sudo rm -rf ~/Downloads/*
echo "you have some stuff to do! add intel_pstate=disable in /etc/default/grub, change color scheme accent, change panel size, remove the ugly fedora icon in kickoff, and also enable detailed telemetry" > ~/"Área de trabalho"/chores
kate ~/"Área de trabalho"/chores && rm ~/"Área de trabalho"/chores
