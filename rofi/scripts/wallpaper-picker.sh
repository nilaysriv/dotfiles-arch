#!/usr/bin/env bash

# Wallpaper picker - launches waypaper GUI

# Check if waypaper is installed
if ! command -v waypaper &> /dev/null; then
    notify-send "Waypaper not found" "Please install waypaper to use this feature" -u critical
    exit 1
fi

# Launch waypaper
waypaper
