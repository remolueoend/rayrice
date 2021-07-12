#!/usr/bin/env bash

ws_name="11:📫 Chat"

# i3-msg 'workspace $ws_name; exec --no-startup-id discord'

# wa_app_id=hnpfjngllnobngcgfapefoaidbinmjnm
# i3-msg "workspace $ws_name"
# if ! pgrep -f "chromium.*$wa_app_id" > /dev/null; then
#     i3-msg "exec --no-startup-id /usr/bin/chromium --profile-directory=Default --app-id=$wa_app_id"
# fi
i3-msg "workspace $ws_name"
if ! pgrep -f "whatsapp-for-linux" > /dev/null; then
    i3-msg "exec --no-startup-id whatsapp-for-linux"
fi

