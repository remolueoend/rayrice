#!/usr/bin/env sh

ws_name="12:🎸 Music"

if [ -z "$(pgrep spotify)" ]; then
    i3-msg "workspace $ws_name; exec spotify"
else
    i3-msg "workspace $ws_name"
fi
