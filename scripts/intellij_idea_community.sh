#!/bin/bash

set -eux

IDEA_VERSION='2025.2.5'

if [[ -f "/usr/share/applications/jetbrains-idea-ce.desktop" || -d "/opt/idea-ce-$IDEA_VERSION" ]]; then
	echo "💻 IntelliJ IDEA Community Edition is already installed. Skipping..."
	exit 0
fi

echo -e "\n💻 Installing IntelliJ IDEA Community Edition $IDEA_VERSION ...\n"

# download intellij community edition if not already downloaded
if [[ ! -f "ideaIC-$IDEA_VERSION.tar.gz" ]]; then
	wget -c "https://download.jetbrains.com/idea/ideaIC-$IDEA_VERSION.tar.gz"
fi

if [[ ! -f "expected_sha256sum.txt" ]]; then
	wget "https://download.jetbrains.com/idea/ideaIC-$IDEA_VERSION.tar.gz.sha256" -O expected_sha256sum.txt
fi

sha256sum ideaIC-$IDEA_VERSION.tar.gz > actual_sha256sum.txt
cat actual_sha256sum.txt | sha256sum -c expected_sha256sum.txt
rm -f actual_sha256sum.txt

# extract and keep the files in /opt
mkdir -p idea-ce-$IDEA_VERSION
tar -zxvf "ideaIC-$IDEA_VERSION.tar.gz" -C idea-ce-$IDEA_VERSION --strip-components 1
mv idea-ce-$IDEA_VERSION /opt

# populate desktop entry
cat > jetbrains-idea-ce.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Community Edition
Icon=/opt/idea-ce-$IDEA_VERSION/bin/idea.svg
Exec="/opt/idea-ce-$IDEA_VERSION/bin/idea.sh" %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea-ce
StartupNotify=true
EOF

# copy the desktop entry to appropriate location
mv jetbrains-idea-ce.desktop /usr/share/applications/
