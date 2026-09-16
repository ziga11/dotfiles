#!/bin/bash

SNAPSHOT_DIR="$HOME/.local/share/tmux/resurrect"
cd "$SNAPSHOT_DIR" || exit 1

SAVE_FILES=( *.save )
if [[ ! -e "${SAVE_FILES[0]}" ]]; then
    tmux display-message "No saved sessions"
    exit 0
fi

SELECTED=$(printf "%s\n" "${SAVE_FILES[@]}" | fzf --prompt="Restore Session: ")
[[ -z "$SELECTED" ]] && exit 0

cp "$SNAPSHOT_DIR/$SELECTED" "$SNAPSHOT_DIR/last"
BRIDGE_ID=$(tmux new-window -d -t 99 -n "restoring" -P -F "#{window_id}")
OLD_WINDOWS=$(tmux list-windows -F "#{window_id}" | grep -v "$BRIDGE_ID")

for win_id in $OLD_WINDOWS; do
    tmux kill-window -t "$win_id" 2>/dev/null
done

tmux run-shell "$HOME/.local/share/tmux/plugins/tmux-resurrect/scripts/restore.sh"

NEW_WINDOW_COUNT=$(tmux list-windows | wc -l)
if (( NEW_WINDOW_COUNT > 1 )); then
    tmux kill-window -t "$BRIDGE_ID"
fi

tmux display-message "Restored $SELECTED"
