#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="${SOURCE:-$ROOT_DIR/artifacts/themes/omarchy-darktable.css}"
TARGET_DIR="${DARKTABLE_THEME_DIR:-$HOME/.config/darktable/themes}"
TARGET_NAME="${DARKTABLE_THEME_NAME:-omarchy.css}"
TARGET="$TARGET_DIR/$TARGET_NAME"
FORCE=0

usage() {
  cat <<'USAGE'
Usage: ./scripts/install-theme.sh [--source PATH] [--force]

Copies the generated theme into the user Darktable theme directory.
This script writes only the target user theme file.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --source)
      SOURCE="${2:?missing path after --source}"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ ! -f "$SOURCE" ]; then
  echo "Theme source not found: $SOURCE" >&2
  echo "Run ./scripts/generate-theme.sh first." >&2
  exit 1
fi

case "$TARGET" in
  "$HOME"/.config/darktable/themes/*) ;;
  *)
    echo "Refusing to install outside \$HOME/.config/darktable/themes: $TARGET" >&2
    exit 1
    ;;
esac

if [ -f "$TARGET" ] && ! grep -q "Downstream Omarchy Native Kit Darktable integration layer" "$TARGET"; then
  if [ "$FORCE" -ne 1 ]; then
    echo "Refusing to overwrite non-generated theme: $TARGET" >&2
    echo "Pass --force only after reviewing the existing file." >&2
    exit 1
  fi
fi

mkdir -p "$TARGET_DIR"
install -m 0644 "$SOURCE" "$TARGET"
echo "Installed $TARGET"
echo "Select the omarchy theme in Darktable preferences."
