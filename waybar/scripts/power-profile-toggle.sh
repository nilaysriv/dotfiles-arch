#!/usr/bin/env bash

# Toggle power profile between performance, balanced, and power-saver

# Check if power-profiles-daemon is available
if ! command -v powerprofilesctl &> /dev/null; then
    notify-send "Power Profiles" "power-profiles-daemon not installed" -u critical
    exit 1
fi

# Get current profile
current=$(powerprofilesctl get 2>/dev/null)

# Determine next profile
case "$current" in
    "performance")
        next="balanced"
        ;;
    "balanced")
        next="power-saver"
        ;;
    "power-saver")
        next="performance"
        ;;
    *)
        next="balanced"
        ;;
esac

# Set new profile
powerprofilesctl set "$next"

# Notify user
notify-send "Power Profile" "Switched to: $next" -t 2000
