#!/bin/zsh
# The Wargus Mac build bundles sdl2-compat, which needs SDL3 at runtime but does not ship it.
# This installs SDL3 with Homebrew, copies it into the app, re-signs the app ad hoc and launches it.
# Usage: zsh fix_sdl3.sh [work_dir]   (default: current directory)
set -e
cd "${1:-$PWD}"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

brew list sdl3 >/dev/null 2>&1 || brew install sdl3
rm -f Wargus.app/Contents/libs/libSDL3.dylib 2>/dev/null || chmod u+w Wargus.app/Contents/libs/libSDL3.dylib
cp -fL "$(brew --prefix sdl3)/lib/libSDL3.0.dylib" Wargus.app/Contents/libs/libSDL3.dylib
chmod u+w Wargus.app/Contents/libs/libSDL3.dylib
xattr -cr Wargus.app
codesign --force --deep -s - Wargus.app
open Wargus.app
echo "Launched Wargus"
