#!/usr/bin/env bash

# Rofi app launcher script with app visibility filtering

# Configuration
ROFI_THEME="$HOME/.config/rofi/app-launcher.rasi"
HIDDEN_APPS_FILE="$HOME/.config/rofi/hidden-apps.txt"

# Create hidden apps file if it doesn't exist
if [ ! -f "$HIDDEN_APPS_FILE" ]; then
    touch "$HIDDEN_APPS_FILE"
fi

# Build exclude string for hidden apps
exclude_string=""
if [ -s "$HIDDEN_APPS_FILE" ]; then
    while IFS= read -r app; do
        if [ -n "$app" ]; then
            exclude_string="${exclude_string} -exclude '${app}'"
        fi
    done < "$HIDDEN_APPS_FILE"
fi

# Launch Rofi with app filtering
eval "rofi -show drun -theme '$ROFI_THEME' $exclude_string"
