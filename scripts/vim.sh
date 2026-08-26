#!/bin/bash

set -eux

echo -e "\n⚡ Installing Vim ...\n"
apt install -y vim-gtk3
echo -e "\n📋 Printing Vim version ...\n"
vim --version
