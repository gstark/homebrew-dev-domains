#!/usr/bin/env bash
set -euo pipefail

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
echo "Starting dnsmasq via Homebrew..."
brew services restart dnsmasq

echo
echo "Done. Next steps:"
echo "  1. Start Caddy with: caddy run --config $REPO_ROOT/caddy/Caddyfile"
echo "  2. Or run: brew services start caddy"
echo "  3. Test DNS with: dig flux.test @127.0.0.1"
