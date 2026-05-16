#!/usr/bin/env bash
set -euo pipefail

DEFAULT_THEME_DIR="$HOME/.config/darktable/themes"
TARGET_DIR="${DARKTABLE_THEME_DIR:-$DEFAULT_THEME_DIR}"
TARGET_NAME="${DARKTABLE_THEME_NAME:-omarchy.css}"
TARGET="$TARGET_DIR/$TARGET_NAME"

usage() {
  cat <<'USAGE'
Usage: ./scripts/rollback.sh

Removes only the generated Omarchy Darktable user theme file.
Select another Darktable theme in preferences before or after running this.
USAGE
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

case "$TARGET_NAME" in
  ""|"."|".."|*/*)
    echo "Invalid DARKTABLE_THEME_NAME; expected a file name, got: $TARGET_NAME" >&2
    exit 1
    ;;
esac

if ! command -v realpath >/dev/null 2>&1; then
  echo "realpath is required for safe target validation." >&2
  exit 1
fi

BASE_REAL="$(realpath -m -- "$DEFAULT_THEME_DIR")"
TARGET_REAL="$(realpath -m -- "$TARGET")"
case "$TARGET_REAL" in
  "$BASE_REAL"/*) ;;
  *)
    echo "Refusing to remove outside \$HOME/.config/darktable/themes: $TARGET" >&2
    exit 1
    ;;
esac

if [ ! -e "$TARGET" ]; then
  echo "No generated theme found at $TARGET"
  exit 0
fi

if ! grep -q "Downstream Omarchy Native Kit Darktable integration layer" "$TARGET"; then
  echo "Refusing to remove file without generated theme marker: $TARGET" >&2
  exit 1
fi

rm "$TARGET"
echo "Removed $TARGET"
