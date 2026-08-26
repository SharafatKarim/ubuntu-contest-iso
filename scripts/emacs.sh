#!/bin/bash

set -eux

if command -v emacs &>/dev/null; then
	echo "Emacs is already installed. Skipping..."
	exit 0
fi

echo "\nInstalling Emacs ...\n"
apt install -y emacs
echo "\nPrinting Emacs version ...\n"
emacs --version
