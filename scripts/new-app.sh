#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <name> <port>"
  echo "Example: $0 billing 4321"
  exit 1
fi

NAME="$1"
PORT="$2"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="$REPO_ROOT/caddy/apps"
TARGET_FILE="$TARGET_DIR/$NAME.caddy"

mkdir -p "$TARGET_DIR"

if [[ -e "$TARGET_FILE" ]]; then
  echo "Refusing to overwrite existing file: $TARGET_FILE"
  exit 1
fi

cat > "$TARGET_FILE" <<EOF
$NAME.test {
	reverse_proxy localhost:$PORT
}
EOF

echo "Created $TARGET_FILE"
echo "Next: reload Caddy with 'make reload-caddy'"
