#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CSS="$ROOT_DIR/artifacts/themes/omarchy-darktable.css"
OUT="${OUT:-$ROOT_DIR/artifacts/screenshots/darktable-live.png}"
WAIT_SECONDS="${WAIT_SECONDS:-8}"

if ! command -v darktable >/dev/null 2>&1; then
  echo "darktable is not installed or not on PATH." >&2
  exit 1
fi

if ! command -v grim >/dev/null 2>&1; then
  echo "grim is required for Wayland capture." >&2
  exit 1
fi

if [ ! -f "$CSS" ]; then
  "$ROOT_DIR/scripts/generate-theme.sh" --colors "$ROOT_DIR/tests/fixtures/omarchy-fixture-colors.toml"
fi

mkdir -p "$(dirname "$OUT")"
CONFIG_DIR="$(mktemp -d)"
CACHE_DIR="$(mktemp -d)"
trap 'rm -rf "$CONFIG_DIR" "$CACHE_DIR"; if [ -n "${DARKTABLE_PID:-}" ]; then kill "$DARKTABLE_PID" 2>/dev/null || true; fi' EXIT

mkdir -p "$CONFIG_DIR/themes"
cp "$CSS" "$CONFIG_DIR/themes/omarchy.css"

darktable \
  --configdir "$CONFIG_DIR" \
  --cachedir "$CACHE_DIR" \
  --library :memory: \
  --disable-opencl \
  --conf ui_last/gui_language=C \
  --conf ui_last/theme=omarchy \
  >/tmp/darktable-omarchy-capture.log 2>&1 &
DARKTABLE_PID="$!"

sleep "$WAIT_SECONDS"
grim "$OUT"

echo "Captured $OUT"
echo "Temporary darktable log: /tmp/darktable-omarchy-capture.log"
