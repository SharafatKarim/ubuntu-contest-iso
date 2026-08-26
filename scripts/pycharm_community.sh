#!/bin/bash

set -eux

PYCHARM_VERSION="2025.2.4"
PYCHARM_NAME="pycharm-community-${PYCHARM_VERSION}"

if [[ -f "/usr/share/applications/jetbrains-pycharm-ce.desktop" || -d "/opt/${PYCHARM_NAME}" ]]; then
	echo "🐍 PyCharm Community Edition is already installed. Skipping..."
	exit 0
fi

echo -e "\n🐍 Install Pycharm Community $PYCHARM_VERSION ..\n"

# download pycharm community edition if not already downloaded
if [[ ! -f "${PYCHARM_NAME}.tar.gz" ]]; then
	wget -c "https://download.jetbrains.com/python/${PYCHARM_NAME}.tar.gz"
fi

if [[ ! -f "expected_sha256sum.txt" ]]; then
	wget "https://download.jetbrains.com/python/${PYCHARM_NAME}.tar.gz.sha256" -O expected_sha256sum.txt
fi

sha256sum ${PYCHARM_NAME}.tar.gz > actual_sha256sum.txt
cat actual_sha256sum.txt | sha256sum -c expected_sha256sum.txt
rm -f actual_sha256sum.txt

# extract and keep the files in /opt
tar -zxvf "${PYCHARM_NAME}.tar.gz"
mv "${PYCHARM_NAME}" /opt

# populate desktop entry
cat > jetbrains-pycharm-ce.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm Community Edition
Icon=/opt/$PYCHARM_NAME/bin/pycharm.svg
Exec="/opt/$PYCHARM_NAME/bin/pycharm.sh" %f
Comment=Python IDE for Developers
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm
StartupNotify=true
EOF

# copy the desktop entry to appropriate location
mv jetbrains-pycharm-ce.desktop /usr/share/applications/
