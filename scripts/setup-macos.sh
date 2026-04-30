#!/usr/bin/env bash
set -euo pipefail

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: required command not found: $1" >&2
    exit 1
  fi
}

require_cmd brew
require_cmd caddy

NIP_IO_IP="${DEV_DOMAINS_IP:-127.0.0.1}"

echo "Using nip.io hostnames with base IP: $NIP_IO_IP"
echo "No dnsmasq or /etc/resolver setup is required."

echo
echo "Starting Caddy via Homebrew..."
brew services restart caddy || brew services start caddy

echo
echo "Done. Next steps:"
echo "  1. Start your dev servers"
echo "  2. Open: http://flux.$NIP_IO_IP.nip.io"
