#!/bin/bash

set -eux

echo -e "\n☕ Installing OpenJDK 17 ...\n"
apt install -y openjdk-17-jdk openjdk-17-jre
echo -e "\n📋 Printing Java version ...\n"
java --version
echo -e "\n📋 Printing Java compiler version ...\n"
javac --version
