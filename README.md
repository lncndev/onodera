<p align="center"><img src="https://raw.githubusercontent.com/onoderaproject/onodera/main/public/assets/images/logo/256.png" /></p>

<h1 align="center">Onodera</h1>
<h3 align="center">v1.1.2 "Kukuru"</h3>

---

Onodera is an anime and manga database similar to MAL (MyAnimeList.) Written in Crystal.

## Installation
Onodera isn't meant to be self-hosted, but you can build it like so:
 1) Install Crystal compiler (AUR: `crystal`), Crystal Shards (AUR: `shards`), and the Lucky framework (AUR: `lucky`)
 2) Clone project
 3) Change directory to `onodera`
 4) Verify you're on the `prod` branch as `main` may contain unstable and/or broken code
 5) `~$ lucky build.release`
 6) Make sure both Postgres and Redis are installed, running, and properly configured in the Onodera config
 7) Run binary

## Why use Onodera?
Because it is and always will be:
 - Fast
 - Privacy-respecting
   - No ads
   - No trackers
 - Transparent
 - Open source
 - Free for everyone (extra functionality with freemium)

## TODO

### TODO before v1 Kukuru
 - ~~Working auth~~
 - ~~Anime support~~
 - ~~Characters support~~
 - ~~Better data hygiene~~
 - ~~Fix Docker image~~

### TODO before v2 Mizuhara
 - ~~MAL scraper~~
 - ~~Official hosted instance~~
 - [WIP] ~~Port to Lucky~~
 - Characters support in Lucky rewrite
 - Onodera Tsukamu: Torrent grabber and downloader
   - Tsukamu Server: Finds and keeps DB of torrents while not actually storing any torrents or magnet links (will be part of Onodera server)
   - Tsukamu Client: Asks server for torrent and downloads it
 - Art
 - Episode support
 - Page edit history

### TODO before v3 Nagatoro
 - Manga support
 - Make data open
   - Add data export
   - Add data import
   - Add data syncing

### TODO before v4 Sumi
 - User profiles
 - Built-in dark mode (use [DarkReader](https://darkreader.org) for now)
 - Better UI
 - Aki tour

### TODO before v5 Sayu
 - ML-powered "smart" recommendations (w/ Freemium)
 - Recommendations
 - And more

## Contributing
### Fixes and other minor changes
 1) Fork it (<https://github.com/onoderaproject/onodera/fork>)
 2) Commit your changes (`git commit -am 'DESCRIPTION OF CHANGES HERE'`)
 3) Push to the branch (`git push origin main`)
 4) Create a new Pull Request

### New feature
 1) Fork it (<https://github.com/onoderaproject/onodera/fork>)
 2) Create your feature branch (`git checkout -b my-new-feature`)
 3) Commit your changes (`git commit -am 'Add some feature'`)
 4) Push to the branch (`git push origin my-new-feature`)
 5) Create a new Pull Request

## Contributors
 - [lncndev](https://gitlab.com/lncn) - creator and maintainer

## Licensing

### Software
lncndev 2021
AGPLv3

### Logo
lncndev 2021
CC-BY-SA
