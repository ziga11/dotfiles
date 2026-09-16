#!/usr/bin/env bash

START_DIR=$(realpath "${1:-$PWD}")
FILE=$(fd --type f --hidden --follow --exclude .git . "$START_DIR" | fzf)

if [[ -n "$FILE" ]]; then
    tmux new-window "nvim '$FILE'; tmux kill-window"
fi

