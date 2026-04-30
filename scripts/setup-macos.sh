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

BASE_DOMAIN="${DEV_DOMAINS_BASE_DOMAIN:-lvh.me}"

echo "Using lvh.me hostnames with base domain: $BASE_DOMAIN"
echo "No dnsmasq or /etc/resolver setup is required for lvh.me."

echo
echo "Starting Caddy via Homebrew..."
brew services restart caddy || brew services start caddy

echo
echo "Done. Next steps:"
echo "  1. Start your dev servers"
echo "  2. Open: http://flux.$BASE_DOMAIN"
