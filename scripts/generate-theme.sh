#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ONK_CLI="${ONK_CLI:-$ROOT_DIR/../omarchy-native-kit/dist/cli.js}"
OUT="$ROOT_DIR/artifacts/themes/omarchy-darktable.css"
COLORS=""
THEME_DIR=""

usage() {
  cat <<'USAGE'
Usage: ./scripts/generate-theme.sh [--colors PATH] [--theme-dir PATH] [--out PATH]

Generates artifacts/themes/omarchy-darktable.css by calling the local
Omarchy Native Kit CLI, then appending this repo's Darktable-specific
native styling layer.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --colors)
      COLORS="${2:?missing path after --colors}"
      shift 2
      ;;
    --theme-dir)
      THEME_DIR="${2:?missing path after --theme-dir}"
      shift 2
      ;;
    --out)
      OUT="${2:?missing path after --out}"
      shift 2
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

if [ ! -f "$ONK_CLI" ]; then
  echo "ONK CLI not found at $ONK_CLI. Set ONK_CLI=/path/to/dist/cli.js." >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT")"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

CMD=(node "$ONK_CLI" integrate darktable)
if [ -n "$COLORS" ]; then
  CMD+=(--colors "$COLORS")
fi
if [ -n "$THEME_DIR" ]; then
  CMD+=(--theme-dir "$THEME_DIR")
fi

"${CMD[@]}" --out "$TMP"

{
  cat "$TMP"
  printf '\n'
  cat "$ROOT_DIR/snippets/darktable-native-overrides.css"
} > "$OUT"

echo "Generated $OUT"
