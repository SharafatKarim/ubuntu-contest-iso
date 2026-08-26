#!/bin/bash

set -eux

# Target allowed domain (edit as needed or set ALLOWED_DOMAIN env variable)
ALLOWED_DOMAIN="${ALLOWED_DOMAIN:-"toph.co"}"
# Upstream DNS server to resolve real IPs (e.g. 1.1.1.1 or contest DNS server IP)
UPSTREAM_DNS="${UPSTREAM_DNS:-"1.1.1.1"}"

echo "Configuring dnsmasq to block all domain resolution except $ALLOWED_DOMAIN..."

# Ensure non-interactive installation
export DEBIAN_FRONTEND=noninteractive

# Install dnsmasq
apt-get install -y dnsmasq

# Disable systemd-resolved DNS stub listener port 53 conflict if active
if systemctl is-active --quiet systemd-resolved; then
	mkdir -p /etc/systemd/resolved.conf.d/
	cat > /etc/systemd/resolved.conf.d/dnsmasq.conf << EOF
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
EOF
	systemctl restart systemd-resolved || true
fi

# Configure dnsmasq:
# 1. server=/domain/upstream_dns -> forward allowed domain queries to upstream DNS server
# 2. address=/#/0.0.0.0          -> wildcard block / sinkhole all other domains to 0.0.0.0
cat > /etc/dnsmasq.d/contest-dns.conf << EOF
# Disable loading /etc/resolv.conf upstream servers automatically
no-resolv

# Forward allowed domain and its subdomains to upstream DNS server for dynamic resolution
server=/${ALLOWED_DOMAIN}/${UPSTREAM_DNS}
server=/*.${ALLOWED_DOMAIN}/${UPSTREAM_DNS}

# Wildcard sinkhole all other domain queries
address=/#/0.0.0.0
EOF

# Point local system /etc/resolv.conf directly to local dnsmasq (127.0.0.1)
rm -f /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf

systemctl restart dnsmasq || true
systemctl enable dnsmasq || true
