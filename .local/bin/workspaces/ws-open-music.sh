#!/usr/bin/env sh

if [ -z "$(pgrep spotify)" ]; then
    i3-msg 'workspace 12:Music; exec spotify'
else
    i3-msg 'workspace 12:Music'
fi
