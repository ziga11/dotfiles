#!/usr/bin/env bash
socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
while read -r line; do
    if [[ "$line" == windowtitlev2* ]]; then
        addr="${line#*>>}"
        addr="${addr%%,*}"
        title=$(hyprctl -j clients | jq -r --arg a "0x$addr" '.[] | select(.address==$a) | .title')
        if [[ "$title" == "Extension: (Raindrop.io) - Bookmark saved"*"Zen Browser" ]]; then
            hyprctl dispatch setfloating "address:0x$addr"
        fi
    fi
done
