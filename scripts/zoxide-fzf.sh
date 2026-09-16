#!/usr/bin/bash

DIR=$(zoxide query -l | fzf)

if [[ -n "$DIR" ]]; then
    tmux send-keys "cd '$DIR'" C-m
fi
