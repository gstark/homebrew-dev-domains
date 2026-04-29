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
require_cmd dnsmasq

BREW_PREFIX="$(brew --prefix)"
DNSMASQ_CONF_DIR="$BREW_PREFIX/etc/dnsmasq.d"
DNSMASQ_MAIN_CONF="$BREW_PREFIX/etc/dnsmasq.conf"
RESOLVER_DIR="/etc/resolver"
RESOLVER_FILE="$RESOLVER_DIR/test"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$DNSMASQ_CONF_DIR"
cp "$REPO_ROOT/dnsmasq/dev.conf" "$DNSMASQ_CONF_DIR/dev.conf"

echo "Copied dnsmasq config to: $DNSMASQ_CONF_DIR/dev.conf"

if ! grep -q '^conf-dir=.*/dnsmasq.d,\*\.conf' "$DNSMASQ_MAIN_CONF" 2>/dev/null; then
  echo
  echo "Please ensure this line exists in: $DNSMASQ_MAIN_CONF"
  echo "conf-dir=$DNSMASQ_CONF_DIR,*.conf"
fi

echo
echo "Creating macOS resolver for .test (sudo required)..."
sudo mkdir -p "$RESOLVER_DIR"
printf 'nameserver 127.0.0.1\n' | sudo tee "$RESOLVER_FILE" >/dev/null

echo
echo "Starting dnsmasq and caddy via Homebrew..."
brew services restart dnsmasq
brew services restart caddy || brew services start caddy

echo
echo "Done. Next steps:"
echo "  1. Start your dev servers"
echo "  2. Test DNS with: dig flux.test @127.0.0.1"
echo "  3. Open: http://flux.test"
