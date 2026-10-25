#!/usr/bin/env bash

START_DIR="${1:-$PWD}"

DIR=$(fd \
    --type d \
    --hidden \
    --follow \
    --exclude .git \
    . "$START_DIR" |
    fzf)

if [[ -n "$DIR" ]]; then
    tmux send-keys "cd -- '$DIR'" C-m
fi
