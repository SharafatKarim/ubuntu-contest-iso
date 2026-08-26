#!/bin/bash

set -eux

# https://linuxhint.com/install-code-blocks-ubuntu/
if command -v codeblocks &>/dev/null; then
	echo "🧱 Codeblocks is already installed. Skipping..."
	exit 0
fi

echo "🧱 Installing Codeblocks ..."

add-apt-repository universe -y
apt install -y codeblocks codeblocks-contrib
