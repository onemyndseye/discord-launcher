# Discord Launcher

**Discord Launcher** is a userland updater and launcher for Discord on Linux. It keeps your Discord installation up-to-date automatically and manages configuration in the user space.

## Features

* Automatically downloads and updates Discord.
* Keeps everything in userland (\~/.discord-bin and \~/.config/discord).
* Optional lid monitoring to automatically kill/relaunch Discord when your laptop lid is closed/opened.
* Lightweight and portable Bash script.

## Installation

Using the provided PKGBUILD for Arch Linux:

```bash
git clone https://github.com/onemyndseye/discord-launcher.git
cd discord-launcher
makepkg -si
```

## Usage

Launch Discord via:

```bash
discord-launcher.sh
# or simply
discord
```

### Options

* `--help` : Show help message.
* `--checklid` : Enable lid state monitoring.
* `--nochecklid` : Disable lid state monitoring.

## Configuration

A basic config file is created at `~/.config/discord/discord-launcher.conf`:

```bash
# Kill/relaunch Discord based on lid state
CHECK_LID=no
# Path to lid state file
LID_PATH=/proc/acpi/button/lid/LID0/state
```

You can edit these options to suit your preferences.

## License

MIT License – see [LICENSE](LICENSE) for details.
