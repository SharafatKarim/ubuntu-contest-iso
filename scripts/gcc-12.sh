#!/bin/bash

set -eux

if command -v gcc-12 &>/dev/null && command -v g++-12 &>/dev/null; then
	echo "⚙️ gcc-12 and g++-12 are already installed. Skipping..."
	exit 0
fi

echo "⚙️ Installing gcc-12, g++-12..."

apt install -y gcc-12 g++-12

update-alternatives \
	--install /usr/bin/gcc gcc /usr/bin/gcc-12 80 \
	--slave /usr/bin/g++ g++ /usr/bin/g++-12 \
	--slave /usr/bin/gcov gcov /usr/bin/gcov-12
