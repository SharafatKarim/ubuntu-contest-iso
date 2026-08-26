#!/bin/bash

set -eux

source vars.sh

echo "👤 Creating admin account, $ADMIN_USER..."
useradd --create-home --shell /bin/bash $ADMIN_USER || true
echo "$ADMIN_USER:$ADMIN_PASSWORD" | chpasswd
usermod -aG sudo $ADMIN_USER

echo "👥 Creating team account, $TEAM_USER..."
useradd --create-home --shell /bin/bash $TEAM_USER || true
echo "$TEAM_USER:$TEAM_PASSWORD" | chpasswd

echo "🎭 Creating mock account, $MOCK_USER..."
useradd --create-home --shell /bin/bash $MOCK_USER || true
echo "$MOCK_USER:$MOCK_PASSWORD" | chpasswd

chmod -R -v 750 /home/*
