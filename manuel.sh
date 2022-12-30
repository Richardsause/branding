#!/bin/sh

cp Manual.odt ~/"Área de trabalho"/"Manual de instruções.odt"
sudo mkdir -p /etc/skel/"Área de trabalho"/
sudo cp Manual.odt /etc/skel/"Área de trabalho"/"Manual de instruções.odt"
