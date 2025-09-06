# Discord Launcher

**Discord Launcher** is a userland updater/launcher script for Discord on Linux. It keeps your Discord installation up-to-date without requiring root privileges or waiting for distribution packages to catch up.

---

## Features

* Automatically downloads the latest Discord release.
* Keeps Discord updated in userland (`~/.discord-bin`).
* Optional lid-state monitoring to kill/relaunch Discord on laptop lid events.
* Installs a desktop entry for easy launching from your application menu.
  ** NOTE:  User must run once to finish installation. 
---

## Installation (Arch Linux / Manjaro)

Build and install the package with `makepkg`:

```bash
git clone https://github.com/onemyndseye/discord-launcher.git
cd discord-launcher
makepkg -si
```

> The package provides `discord` and `discord-launcher` commands.

---

## First Run

After installation, run the launcher manually at least once to initialize Discord:

```bash
discord-launcher.sh
 or
discord
```

This will download Discord into `~/.discord-bin` and set up your configuration and desktop entry.

---

## Configuration

A default configuration file will be created at `~/.config/discord/discord-launcher.conf`.

Example options:

```bash
# Enable lid-state monitoring (yes/no)
CHECK_LID=no

# Path to lid state file
LID_PATH=/proc/acpi/button/lid/LID0/state
```

---

## Usage

* Launch Discord normally:

```bash
discord
# or
discord-launcher
```

* Override lid monitoring temporarily:

```bash
discord-launcher --checklid   # enable lid monitoring for this session
discord-launcher --nochecklid # disable lid monitoring for this session
```

* Show help:

```bash
discord-launcher --help
```

---

## License

MIT License
