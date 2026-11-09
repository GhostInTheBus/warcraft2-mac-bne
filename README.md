# warcraft2-mac-bne

Play Warcraft II Battle.net Edition natively on an Apple Silicon Mac, using your own disc and the open source Wargus engine.

This repo holds two small helper scripts and the notes on why they are needed. It is not a fork. Wargus and Stratagus are not modified here. All the real work is theirs.

## What you need

1. Your own Warcraft II Battle.net Edition disc (or an image of it). This repo contains no game data and never will.
2. An Apple Silicon Mac with [Homebrew](https://brew.sh).
3. The Wargus Mac build, `Wargus-arm64.dmg`, from the [Wargus GitHub Actions artifacts](https://github.com/Wargus/wargus/actions) (the `Wargus-macOS-arm64` artifact on a recent master run).

## Setup

Make a working folder with this layout:

```
work/
  app/Wargus-arm64.dmg
  bne_data/            copied from your disc, see below
```

From the disc, copy `INSTALL.EXE` and the whole `SUPPORT` folder (it holds `TOMES/TOME.1` and friends) into `bne_data/`. If you only have a bin/cue image, see [docs/disc-images.md](docs/disc-images.md).

Then run:

```sh
zsh scripts/extract_wargus.sh work
zsh scripts/fix_sdl3.sh work
```

The first script unpacks the app and converts the game data into `~/Library/Application Support/Stratagus/data.Wargus`. The second fixes a missing library and launches the game.

## Why two scripts

Short version, details in [docs/TIL.md](docs/TIL.md):

* The Mac build bundles `sdl2-compat`, which needs SDL3 at runtime but does not include it.
* The UI art is shipped as `contrib` but Wargus reads it from `graphics/ui`, so it has to be copied there or the game refuses to start.

## Known gaps

* Cutscene videos are not converted yet, so the `videos` folder stays empty.
* Only tested on one machine. Reports welcome, see [CONTRIBUTING.md](CONTRIBUTING.md).

## Docs

* [docs/TIL.md](docs/TIL.md) what I learned getting this running
* [docs/ELI5.md](docs/ELI5.md) the whole thing explained simply
* [docs/disc-images.md](docs/disc-images.md) turning a bin/cue image into files you can copy

## Credits and legal

* [Wargus](https://github.com/Wargus/wargus) and [Stratagus](https://github.com/Wargus/stratagus), GPL-2.0. They do the heavy lifting.
* Warcraft II is a trademark of Blizzard Entertainment. This project is not affiliated with or endorsed by Blizzard. You must own a copy of the game.
* Scripts in this repo are MIT licensed, see [LICENSE](LICENSE).
