#!/usr/bin/bash

SELECTED=$(compgen -c | sort -u | fzf)

if [[ -n "$SELECTED" ]]; then
    clear
    tldr "$SELECTED"
    read -n 1
fi
