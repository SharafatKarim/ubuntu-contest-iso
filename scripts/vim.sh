#!/bin/bash

set -eux

if command -v vim &>/dev/null; then
	echo "⚡ Vim is already installed. Skipping..."
	exit 0
fi

echo -e "\n⚡ Installing Vim ...\n"
apt install -y vim-gtk3
echo -e "\n📋 Printing Vim version ...\n"
vim --version
