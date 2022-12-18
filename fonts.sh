#!/bin/sh
curl https://fonts.google.com/download?family=Inter > inter.zip
unzip inter.zip
rm -rf static
mkdir -p ~/.local/share/fonts/
mv "Inter-VariableFont_slnt,wght.ttf" ~/.local/share/fonts/inter.ttf
