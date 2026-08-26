#!/bin/bash

set -eux

WALLPAPER_SRC="wallpaper.jpg"
TARGET_DIR="/usr/share/backgrounds"
TARGET_PATH="$TARGET_DIR/contest_wallpaper.jpg"

if [[ -f "$WALLPAPER_SRC" ]]; then
	echo "🖼️ Installing custom wallpaper..."
	mkdir -p "$TARGET_DIR"
	cp -v "$WALLPAPER_SRC" "$TARGET_PATH"

	# Set default wallpaper for GNOME / GDM users via dconf profile overrides
	mkdir -p /etc/dconf/profile
	cat > /etc/dconf/profile/user << 'EOF'
user-db:user
system-db:local
EOF

	mkdir -p /etc/dconf/db/local.d
	cat > /etc/dconf/db/local.d/00-wallpaper << EOF
[org/gnome/desktop/background]
picture-uri='file://$TARGET_PATH'
picture-uri-dark='file://$TARGET_PATH'
picture-options='zoom'

[org/gnome/desktop/screensaver]
picture-uri='file://$TARGET_PATH'
picture-options='zoom'
EOF

	dconf update || true
else
	echo "Notice: $WALLPAPER_SRC not found. Place a wallpaper image named '$WALLPAPER_SRC' in the repository root to enable custom wallpaper."
fi
