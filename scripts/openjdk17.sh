#!/bin/bash

set -eux

if command -v javac &>/dev/null && java -version 2>&1 | grep -q "17\."; then
	echo "☕ OpenJDK 17 is already installed. Skipping..."
	exit 0
fi

echo -e "\n☕ Installing OpenJDK 17 ...\n"
apt install -y openjdk-17-jdk openjdk-17-jre
echo -e "\n📋 Printing Java version ...\n"
java --version
echo -e "\n📋 Printing Java compiler version ...\n"
javac --version
