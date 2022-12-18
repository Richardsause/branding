#!/bin/sh
## Swap
mkdir -p /var/swap
chattr +C /var/swap
dd if=/dev/zero of=/var/swap/swapfile bs=1M count=4096 status=progress
mkswap -U clear /var/swap/swapfile
chmod 0600 /var/swap/swapfile
echo "/var/swap/swapfile none swap pri=0 0 0" >> /etc/fstab
swapon -p 0 /var/swap/swapfile
notify-send "on disk swap has been applied with priority 0 on the system"

## oomd
systemctl stop systemd-oomd
systemctl mask systemd-oomd
notify-send "systemd-oomd has been masked on the system"
