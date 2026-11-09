# TIL

* Old Wargus docs say Battle.net Edition is unsupported. That is outdated. The current `wartool` detects `SUPPORT/TOMES/TOME.1` and `INSTALL.EXE` and reads them with StormLib.
* The Wargus Mac build ships `libSDL2-2.0.0.dylib`, which is really `sdl2-compat`, a shim that forwards to SDL3. SDL3 is not bundled, so the app dies with "Failed loading SDL3 library" until you copy `libSDL3.dylib` into `Contents/libs`.
* Copying a library out of Homebrew keeps it read only, so a second run of a script that overwrites it fails with "Permission denied". Remove or `chmod u+w` first.
* After changing anything inside an app bundle on Apple Silicon you need to re-sign it, ad hoc is enough: `codesign --force --deep -s - Wargus.app`.
* `wargus.cpp` maps `contrib` to `graphics/ui`. If the UI art lands anywhere else you get "Stratagus failed to load game data" and a missing `black_title.png` in the log.
* A bin/cue image is just 2352 byte sectors with the data in the middle 2048 bytes. Stripping 16 header bytes per sector gives a valid ISO.
