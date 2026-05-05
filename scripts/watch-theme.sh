#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEME_DIR="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/current/theme}"
COLORS_PATH="${COLORS_PATH:-$THEME_DIR/colors.toml}"
INTERVAL="${INTERVAL:-2}"
OUT="${OUT:-$ROOT_DIR/artifacts/themes/omarchy-darktable.css}"

usage() {
  cat <<'USAGE'
Usage: ./scripts/watch-theme.sh

Watches the active Omarchy colors.toml and regenerates the repo artifact.
It does not install or mutate Darktable configuration.

Env:
  OMARCHY_THEME_DIR=/path/to/theme
  COLORS_PATH=/path/to/colors.toml
  INTERVAL=2
  OUT=artifacts/themes/omarchy-darktable.css
USAGE
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ ! -f "$COLORS_PATH" ]; then
  echo "No colors.toml found at $COLORS_PATH" >&2
  exit 1
fi

last=""
while true; do
  current="$(stat -c '%Y:%s' "$COLORS_PATH")"
  if [ "$current" != "$last" ]; then
    "$ROOT_DIR/scripts/generate-theme.sh" --colors "$COLORS_PATH" --out "$OUT"
    last="$current"
  fi
  sleep "$INTERVAL"
done
