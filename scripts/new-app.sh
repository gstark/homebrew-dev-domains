#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 --name <name> --port <port>"
  echo "Example: $0 --name billing --port 4321"
}

NAME=""
PORT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)
      NAME="${2:-}"
      shift 2
      ;;
    --port)
      PORT="${2:-}"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$NAME" || -z "$PORT" ]]; then
  usage >&2
  exit 1
fi

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
echo "Next: reload Caddy with 'dev-domains reload'"
