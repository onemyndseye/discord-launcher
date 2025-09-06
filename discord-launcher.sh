#!/bin/bash


# Settable options
DISCORD_URL='https://discord.com/api/download?platform=linux&format=tar.gz'
DISCORD_BIN=~/.discord-bin
DISCORD_CFG=~/.config/discord


# Gather needed info
headers=$(curl -sI $DISCORD_URL)
filename=$(echo "$headers" | grep -i '^location:' | awk -F '/' '{print $NF}' | tr -d '\r')
version=$(echo "$filename" |sed '{s|.tar.gz||g}' |sed '{s|discord-||g}')


# Source user config if it exists
CONFIG_FILE="$DISCORD_CFG/discord-launcher.conf"
if [ -f "$CONFIG_FILE" ]; then
    # shellcheck disable=SC1090
    source "$CONFIG_FILE"
else
  echo '# Basic config file for discord-launcher' >$CONFIG_FILE
  echo '#' >>$CONFIG_FILE
  echo '# Kill/relaunch discord based on lid state' >>$CONFIG_FILE
  echo 'CHECK_LID=no' >>$CONFIG_FILE
  echo "# Path to lid state file"
  echo 'LID_PATH=/proc/acpi/button/lid/LID0/state' >>$CONFIG_FILE
fi
CHECK_LID=${CHECK_LID:-no}


check_update() {
# Check if upgrade is needed
mkdir -p "$DISCORD_CFG"
cd $DISCORD_CFG

VER_CHK=$(ls |grep "$version")
[ -n "$FORCEUPDATE" ] && VER_CHK=""
if [ -z "$VER_CHK" ]; then
  # Discord is out of date. Lets update
  TMP=$(mktemp -d)
  cd $TMP
  wget $DISCORD_URL -O "./$filename"
  tar -xvf "$filename"  
  cd Discord
  mkdir -p $DISCORD_BIN
  cp -avr * $DISCORD_BIN/.
  cd $DISCORD_BIN
  rm -rfd $TMP
  # Call postinst.sh from the discord payload
  ./postinst.sh

  # Update Exec to point to your launcher
  sed -i "s|Exec=.*|Exec=/usr/bin/discord-launcher.sh|g" ./discord.desktop

  # Update Icon to point to the icon inside $DISCORD_BIN
  DISCORD_BIN_FULLPATH="$(realpath $DISCORD_BIN)"
  sed -i "s|Icon=.*|Icon=$DISCORD_BIN_FULLPATH/discord.png|g" ./discord.desktop

  # Install the desktop file
  mkdir -p ~/.local/share/applications
  cp discord.desktop ~/.local/share/applications/
  xdg-desktop-menu forceupdate
fi
}


do_kill() {
# Kill all instances of discord
pkill -9 Discord 2>&1 >/dev/null
sleep 2

}


do_launch() {
# Check for updates during launch
check_update


# Launch Discord
$DISCORD_BIN/Discord >"$DISCORD_CFG/discordapp.log" 2>&1 &
sleep 1
}


do_help() {
cat <<EOF
Usage: $0 [OPTION]

Options:
  --help        Show this help message and exit
  --ignorelid   Launch Discord without monitoring lid state
EOF
}


# Main Proc
# --- parse command line ---
case "$1" in
    --help)
        do_help
        exit 0
        ;;
    --checklid)
        # Monitor lid state
        CHECK_LID=yes
        ;;
    --nochecklid)
        # Monitor lid state
        CHECK_LID=no
        ;;
    --update)
        # Monitor lid state
        FORCEUPDATE=1
        check_update
        echo ""
        echo "Discord is ready to launch!"
        exit 0
        ;;
    "")
        ;;  # no option → normal behavior
    *)
        echo "Unknown option: $1"
        do_help
        exit 1
        ;;
esac


# Kill any running instances
do_kill



if [ "$CHECK_LID" = "yes" ]; then
    if [ ! -f "$LID_PATH" ]; then
      echo "Lid monitoring is defined but state file does not exist.  Please check config file!"
    exit 127
    fi
    LAST_STATE=""
    while true; do
        CUR_STATE=$(grep -oE 'open|closed' "$LID_PATH")
        if [ "$CUR_STATE" != "$LAST_STATE" ]; then
            case "$CUR_STATE" in
                closed)
                    do_kill
                    ;;
                open)
                    do_launch
                    ;;
            esac
            LAST_STATE=$CUR_STATE
        fi
        sleep 2
    done
else
    do_launch
fi




