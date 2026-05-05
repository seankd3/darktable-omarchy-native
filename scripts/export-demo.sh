#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCREENSHOT="$ROOT_DIR/artifacts/screenshots/omarchy-darktable-demo.svg"

if [ ! -f "$ROOT_DIR/artifacts/themes/omarchy-darktable.css" ]; then
  "$ROOT_DIR/scripts/generate-theme.sh" --colors "$ROOT_DIR/tests/fixtures/omarchy-fixture-colors.toml"
fi

if [ ! -f "$SCREENSHOT" ]; then
  echo "Missing demo screenshot artifact: $SCREENSHOT" >&2
  exit 1
fi

echo "Demo page: $ROOT_DIR/demo/index.html"
echo "Demo screenshot artifact: $SCREENSHOT"
