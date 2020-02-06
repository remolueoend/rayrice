# Switch to US international with Caps as Mod/Escape
setxkbmap -option caps:super -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
# swap left alt <=> left ctrl (currently not working due to other xkb overrides):
# setxkbmap -option caps:super -option ctrl:swap_lalt_lctl -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &

# Properties button extra Mod/Escape
xmodmap -e 'keycode 135 = Super_R' &
xset r rate 200 50 &	# Speed xrate up

# load custom keybindings
xkbcomp $HOME/voidrice/xkb.dump $DISPLAY
