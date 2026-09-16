#!/bin/bash

SNAPSHOT_DIR="$HOME/.tmux/resurrect"
mkdir -p "$SNAPSHOT_DIR"

DIR=$(tmux display -p -F "#{pane_current_path}")
DIR_NAME=$(basename "$DIR")
SESSION_NAME="${DIR_NAME:-session}"

LAST_FILE="$SNAPSHOT_DIR/last"
OLD_TS=0
[[ -f "$LAST_FILE" ]] && OLD_TS=$(stat -c %Y "$LAST_FILE")

tmux run-shell "$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"

MAX_WAIT=5
SECONDS_PASSED=0
while [[ $SECONDS_PASSED -lt $MAX_WAIT ]]; do
    NEW_TS=0
    [[ -f "$LAST_FILE" ]] && NEW_TS=$(stat -c %Y "$LAST_FILE")
    
    if [ "$NEW_TS" -gt "$OLD_TS" ]; then
        # File has been updated!
        cp "$LAST_FILE" "$SNAPSHOT_DIR/${SESSION_NAME}.save"
        tmux display-message "Snapshot saved: ${SESSION_NAME}.save"
        exit 0
    fi
    
    sleep 0.5
    ((SECONDS_PASSED++))
done

tmux display-message "Error: Save timed out or 'last' file not found."
