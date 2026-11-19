#!/usr/bin/env bash
# Pack the cross-platform NapCat payload for Linux / macOS.
#
# The shell build output mixes two kinds of files:
#   - cross-platform: napcat.mjs, loadNapCat.js, static/, worker/, native/, config/
#   - Windows-only  : NapCatWinBootMain.exe, NapCatWinBootHook.dll, *.bat, *.ps1
#
# Linux and macOS only need the first kind: QQ is Electron, so pointing its
# resources/app/package.json "main" at ./napcat/napcat.mjs is enough.
#
# Usage: ./scripts/pack-crossplatform.sh [output.zip]
# Run `pnpm build:webui && pnpm build:shell` first.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/packages/napcat-shell/dist"
OUT="${1:-$ROOT/NapCat.Shell.Linux-macOS.zip}"

if [ ! -f "$DIST/napcat.mjs" ]; then
  echo "error: $DIST/napcat.mjs not found. Run 'pnpm build:webui && pnpm build:shell' first." >&2
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/napcat"

for item in napcat.mjs loadNapCat.js static worker native config package.json qqnt.json; do
  cp -r "$DIST/$item" "$TMP/napcat/"
done
cp "$DIST"/conout-*.js "$TMP/napcat/"

# Keep the install notes next to the payload.
if [ -f "$ROOT/docs/INSTALL-Linux-macOS.md" ]; then
  cp "$ROOT/docs/INSTALL-Linux-macOS.md" "$TMP/napcat/"
fi

cd "$TMP"
if command -v zip >/dev/null 2>&1; then
  zip -qr "$OUT" napcat
elif command -v 7z >/dev/null 2>&1; then
  7z a -tzip -mx=5 "$OUT" napcat >/dev/null
elif [ -x "/c/Program Files/7-Zip/7z.exe" ]; then
  "/c/Program Files/7-Zip/7z.exe" a -tzip -mx=5 "$OUT" napcat >/dev/null
else
  echo "error: need 'zip' or '7z' on PATH." >&2
  exit 1
fi

echo "wrote $OUT"
du -h "$OUT" 2>/dev/null || true
