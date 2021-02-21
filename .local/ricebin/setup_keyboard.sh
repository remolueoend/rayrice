#!/bin/sh

# This script is called on startup to remap keys.
# Increase key speed via a rate change
xset r rate 200 50
# Map the caps lock key to super...
setxkbmap \
    -option caps:super \
    -variant altgr-intl
# But when it is pressed only once, treat it as escape.
killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape'
# Map the menu button to right super as well.
xmodmap -e 'keycode 135 = Super_R'

# load custom XKB overwrites:
setxkbmap -print | \
    sed 's/\(xkb_symbols.*\)"/\1+custom_t490(umlauts)"/' | \
    xkbcomp -I$HOME/.config/xkb -synch - $DISPLAY 2>/dev/null

# load udevmon_layer config:
# currently not required, an initial config is loaded based on the keyboard identifier
# $HOME/dev/remolueoend/udevmon-layers/packages/udevmon_layers_ts/scripts/load_config \
#     $HOME/.config/udevmon_layers/laptop.json
