#!/bin/sh

## DNF related stuff
sudo dnf up -y
echo "updated the system"

# Removing software
sudo dnf rm *akonadi* *akregator* *games* *krfb* *krdc* kwrite *konversation* *abrt* *firefox* *qt5-qdbusviewer* *power-profiles-daemon* -y
echo "removed all the bloat"

# Installing RPM fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-nonfree-release-tainted -y
sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware" -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y
sudo dnf install intel-media-driver libva-intel-driver -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
echo "rpm fusion is fully setup"

# Installing some software
sudo dnf in chromium-freeworld thunderbird kgpg thermald plasma-browser-integration ktorrent
sudo systemctl enable thermald
echo "all the apps installed, and thermald has been enabled"

# hblock
curl -o /tmp/hblock 'https://raw.githubusercontent.com/hectorm/hblock/v3.4.0/hblock' \
  && echo '4031d86cd04fd7c6cb1b7e9acb1ffdbe9a3f84f693bfb287c68e1f1fa2c14c3b  /tmp/hblock' | shasum -c \
  && sudo mv /tmp/hblock /usr/local/bin/hblock \
  && sudo chown 0:0 /usr/local/bin/hblock \
  && sudo chmod 755 /usr/local/bin/hblock
sudo systemctl enable hblock.timer
echo "hblock is working"

# auto-cpufreq
sudo dnf in plasma-discover-snap snapd -y
sudo snap install auto-cpufreq -y
sudo systemctl enable auto-cpufreq
echo "auto-cpufreq is working"

## Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
flatpak update -y
flatpak install org.gtk.Gtk3theme.Breeze -y
flatpak override --filesystem=xdg-config/gtk-3.0:ro
flatpak override --filesystem=xdg-config/gtk-4.0:ro
flatpak override --filesystem=xdg-config/gtk-2.0:ro
echo "flatpak is configured"

## Fixing the system
sudo systemctl disable systemd-oomd
# swap
sudo chattr +C /swap/
sudo dd if=/dev/zero of=/swap/swapfile bs=1M count=4096 status=progress
sudo echo "/swap/swapfile none swap pri=0,discard 0 0" >> /etc/fstab
echo "swap is configured"

# grub
sudo echo "GRUB_TIMEOUT=5" > /etc/default/grub
sudo echo "GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"" >> /etc/default/grub
sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
sudo echo "GRUB_DISABLE_SUBMENU=true" >> /etc/default/grub
sudo echo "GRUB_TERMINAL_OUTPUT="console"" >> /etc/default/grub
sudo echo "GRUB_CMDLINE_LINUX="rhgb quiet intel_pstate=disable"" >> /etc/default/grub
sudo echo "GRUB_DISABLE_RECOVERY="true"" >> /etc/default/grub
sudo echo "GRUB_ENABLE_BLSCFG=true" >> /etc/default/grub
echo "new /etc/default/grub written, generating its .cfg..."
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
echo "grub has been configured"

# fixing up the cursors
mkdir ~/.icons/
mkdir ~/.icons/default
echo "[Icon Theme]" > ~/.icons/default/index.theme
echo "Inherits=breeze_cursors" >> ~/.icons/default/index.theme
ln -s /usr/share/icons/breeze_cursors/cursors ~/.icons/default/cursors
echo "default cursor theme added to plasma settings"

cd "Área de trabalho"
curl https://raw.githubusercontent.com/Richardsause/branding/main/trash%3A%E2%81%84.desktop > trash:/.desktop
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
plasma-apply-colorscheme BreezeRRT.colors
echo "branding downloaded, and applied, removing stuff in ~/Downloads"
sudo rm -rf ~/Downloads/*