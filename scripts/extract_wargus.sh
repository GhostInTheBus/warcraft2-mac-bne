#!/bin/zsh
# Unpacks the Wargus Mac build and converts Warcraft II Battle.net Edition data into it.
# Usage: zsh extract_wargus.sh [work_dir]   (default: current directory)
# Expects in work_dir:  app/Wargus-arm64.dmg   and   bne_data/ (from your own disc)
set -e
cd "${1:-$PWD}"
DEST="$HOME/Library/Application Support/Stratagus/data.Wargus"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

if [ ! -d Wargus.app ]; then
  hdiutil attach -nobrowse -readonly -mountpoint /tmp/wargus_dmg app/Wargus-arm64.dmg
  cp -R /tmp/wargus_dmg/*.app .
  hdiutil detach /tmp/wargus_dmg
  [ -d Wargus.app ] || mv *.app Wargus.app
fi
xattr -cr Wargus.app

command -v ffmpeg >/dev/null || brew install ffmpeg

mkdir -p "$DEST"
for d in campaigns maps shaders scripts; do
  cp -R "Wargus.app/Contents/MacOS/$d" "$DEST/"
done
# The UI art ships as "contrib" but Wargus looks for it in graphics/ui
mkdir -p "$DEST/graphics/ui"
cp -R Wargus.app/Contents/MacOS/contrib/. "$DEST/graphics/ui/"

"Wargus.app/Contents/MacOS/wartool" -v -r bne_data "$DEST"
echo "Done. Next: zsh fix_sdl3.sh"
