# Discord Launcher

A simple userland Discord updater/launcher script for Linux.\
This script automatically downloads, installs, and updates Discord
without relying on system packages.

------------------------------------------------------------------------

## Features

-   Always downloads the latest official Discord release
-   Keeps binaries isolated in `~/.discord-bin`
-   Stores configuration in `~/.config/discord`
-   Creates a `.desktop` entry for menu integration
-   Optional lid-state monitoring (kill/restart on laptop lid
    open/close)

------------------------------------------------------------------------

## Installation

### Arch Linux / Manjaro (via `makepkg`)

``` bash
git clone https://github.com/onemyndseye/discord-launcher.git
cd discord-launcher
makepkg -si
```

### Other Linux Distributions

``` bash
git clone https://github.com/onemyndseye/discord-launcher.git
cd discord-launcher
chmod +x discord-launcher.sh
./discord-launcher.sh
```

------------------------------------------------------------------------

## Usage

``` bash
discord-launcher.sh [OPTION]
```

Options: - `--help` Show help message - `--update` Force update
Discord - `--checklid` Enable lid-state monitoring - `--nochecklid`
Disable lid-state monitoring

------------------------------------------------------------------------

## Notes

-   On first run, the script downloads Discord and sets up a desktop
    entry.

-   If the menu entry doesn't show up immediately, log out and back in,
    or run:

    ``` bash
    xdg-desktop-menu forceupdate
    ```

-   Config is stored in `~/.config/discord/discord-launcher.conf`.

------------------------------------------------------------------------

## License

MIT
