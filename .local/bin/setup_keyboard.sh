# Switch to US international with Caps as Mod/Escape
setxkbmap \
    -option caps:super \
    -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &

# Properties button extra Mod/Escape
xmodmap -e 'keycode 135 = Super_R' &
xset r rate 200 50 &	# Speed xrate up

# load custom XKB overwrites:
setxkbmap -print | \
    sed 's/\(xkb_symbols.*\)"/\1+custom_t490(umlauts)"/' | \
    xkbcomp -I$HOME/.config/xkb -synch - $DISPLAY 2>/dev/null

# load layer config:
$HOME/src/udevmon-layers/packages/udevmon_layers_ts/scripts/load_config \
    $HOME/.config/udevmon_layers/laptop.json
