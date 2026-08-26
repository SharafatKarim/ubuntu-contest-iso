#!/bin/bash

set -eux

if command -v geany &>/dev/null; then
	echo "💡 Geany is already installed. Skipping..."
	exit 0
fi

echo -e "\n💡 Installing Geany ...\n"
apt install -y geany
echo -e "\n📋 Printing Geany version ...\n"
geany --version
