#!/usr/bin/bash
SELECTED=$(compgen -c | fzf)
if [[ -n "$SELECTED" ]]; then
    tmux send-keys "tldr '$SELECTED'" C-m
fi
