#!/bin/bash

set -eux

echo -e "\n💡 Installing Geany ...\n"
apt install -y geany
echo -e "\n📋 Printing Geany version ...\n"
geany --version
