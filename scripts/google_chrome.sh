#!/bin/bash

set -eux

if command -v google-chrome &>/dev/null; then
	echo "🌐 Google Chrome is already installed. Skipping..."
	exit 0
fi

echo "🌐 Installing Google Chrome..."

if [[ ! -f "google-chrome-stable_current_amd64.deb" ]]; then
	wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
fi
dpkg -i google-chrome-stable_current_amd64.deb || apt-get install -f -y
