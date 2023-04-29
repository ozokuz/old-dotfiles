#!/bin/sh

run() {
  if ! pgrep -f "$1";
  then
    "$@"&
  fi
}

run picom
run lxpolkit

# Sets the key repeat delay and rate.
xset r rate 500 30

# Check if the script is being run again when awesome is reloaded
if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then
  exit
fi

# Remember that the script has been run
echo "awesome.started:true" | xrdb -merge

# Use dex to run XDG Autostart files
dex --environment Awesome --autostart
playerctld daemon
pactl set-source-volume alsa_input.usb-Elgato_Systems_Elgato_Wave_3_BS29J1A01047-00.mono-fallback 48%
#pactl set-source-mute alsa_input.usb-Elgato_Systems_Elgato_Wave_3_BS29J1A01047-00.mono-fallback 1
#xcape -e 'Super_L=Escape'
SSH_ASKPASS=/usr/bin/lxqt-openssh-askpass ssh-add >/dev/null </dev/null &
