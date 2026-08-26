#!/bin/bash

set -eux

if command -v python3.11 &>/dev/null; then
	echo "🐍 Python 3.11 is already installed. Skipping..."
	exit 0
fi

echo "🐍 Installing Python 3.11..."

apt install -y python3-full
