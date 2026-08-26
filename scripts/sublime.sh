#!/bin/bash

set -eux

echo -e "\n📝 Installing Sublime Text 4 ...\n"
apt install -y wget gpg
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor >> /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" >> /etc/apt/sources.list.d/sublime-text.list
# apt update
apt install -y apt-transport-https
apt install -y sublime-text

echo -e "\n📋 Printing Sublime Text version ...\n"
subl --version
