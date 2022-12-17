#!/bin/sh
### Swap
mkdir -p /var/swap # make the directory
chattr +C /var/swap # make the swap subvolume
dd if=/dev/zero of=/var/swap/swapfile bs=1M count=4096 status=progress # make the swap file
mkswap -U clear /var/swap/swapfile # format the file to swap
chmod 0600 /var/swap/swapfile # change the
echo "/var/swap/swapfile none swap pri=0 0 0" >> /etc/fstab
swapon -p 0 /var/swap/swapfile
systemctl stop systemd-oomd
systemctl mask systemd-oomd
