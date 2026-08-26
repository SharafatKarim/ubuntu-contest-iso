#!/bin/bash

set -eux

echo -e "\n🧹 Cleaning up downloaded installer archives and temporary files...\n"

# Remove downloaded tarballs, zips, deb files, and checksums from root / working directory
rm -f \
	google-chrome-stable_current_amd64.deb \
	pycharm-community-*.tar.gz \
	ideaIC-*.tar.gz \
	eclipse.tar.gz \
	kotlin-compiler.zip \
	expected_sha256sum.txt \
	actual_sha256sum.txt

# Clean apt cache
apt-get clean -y
apt-get autoremove -y

echo -e "\n✨ Cleanup complete!\n"
