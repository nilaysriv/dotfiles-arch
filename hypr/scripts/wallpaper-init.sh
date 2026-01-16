#!/usr/bin/env bash

# Wallpaper initialization script
# Loads last used wallpaper or sets a default

WALLPAPER_CACHE="$HOME/.cache/current-wallpaper"
DEFAULT_WALLPAPER="$HOME/Pictures/wallpapers/default.jpg"

# Check if swww daemon is running
if ! pgrep -x swww-daemon > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Load last wallpaper if available
if [ -f "$WALLPAPER_CACHE" ] && [ -f "$(cat "$WALLPAPER_CACHE")" ]; then
    wallpaper=$(cat "$WALLPAPER_CACHE")
    swww img "$wallpaper" --transition-type=fade --transition-duration=1
else
    # Try to set default wallpaper if it exists
    if [ -f "$DEFAULT_WALLPAPER" ]; then
        swww img "$DEFAULT_WALLPAPER" --transition-type=fade --transition-duration=1
        echo "$DEFAULT_WALLPAPER" > "$WALLPAPER_CACHE"
    fi
fi
