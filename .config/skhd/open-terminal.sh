#!/usr/bin/env sh

osascript <<EOF
on is_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_running

if not is_running("iTerm2") then
  tell application "iTerm" to activate
end if

tell application "iTerm"
    create window with default profile
end tell

EOF
