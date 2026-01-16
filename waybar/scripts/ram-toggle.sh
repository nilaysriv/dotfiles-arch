#!/usr/bin/env bash

# Toggle RAM display mode between percentage and actual memory

STATE_FILE="$HOME/.cache/ram-display-mode"

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$STATE_FILE")"

# Read current mode
if [ ! -f "$STATE_FILE" ]; then
    echo "percentage" > "$STATE_FILE"
    current_mode="percentage"
else
    current_mode=$(cat "$STATE_FILE")
fi

# Toggle mode
if [ "$current_mode" = "percentage" ]; then
    echo "memory" > "$STATE_FILE"
else
    echo "percentage" > "$STATE_FILE"
fi

# Force Waybar to refresh the module
pkill -RTMIN+8 waybar
