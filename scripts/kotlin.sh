#!/bin/bash

set -eux

KOTLIN_VERSION="2.1.10"

echo -e "\nInstalling Kotlin Compiler $KOTLIN_VERSION ...\n"

export DEBIAN_FRONTEND=noninteractive
apt-get install -y wget unzip openjdk-17-jre-headless

# Download Kotlin compiler standalone zip release from GitHub
wget -c -O kotlin-compiler.zip "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip"

# Unpack to /opt/kotlinc
rm -rf /opt/kotlinc
unzip -q kotlin-compiler.zip -d /opt/
rm -f kotlin-compiler.zip

# Symlink binaries to /usr/local/bin so kotlinc and kotlin are in PATH
ln -sf /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc
ln -sf /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin

echo -e "\nPrinting Kotlin compiler version ...\n"
kotlinc -version
