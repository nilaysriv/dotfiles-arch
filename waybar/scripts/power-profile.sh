#!/usr/bin/env bash

# Power Profile Manager Script for Waybar
# Shows current power profile and allows cycling through them

# Check if power-profiles-daemon is available
if ! command -v powerprofilesctl &> /dev/null; then
    echo '{"text": "N/A", "tooltip": "power-profiles-daemon not installed"}'
    exit 0
fi

# Get current power profile
profile=$(powerprofilesctl get 2>/dev/null)

if [ -z "$profile" ]; then
    echo '{"text": "N/A", "tooltip": "Unable to get power profile"}'
    exit 0
fi

# Set icon and tooltip based on profile
case "$profile" in
    "performance")
        icon="󰓅"
        tooltip="Performance Mode\nClick to switch"
        class="performance"
        ;;
    "balanced")
        icon="󰾅"
        tooltip="Balanced Mode\nClick to switch"
        class="balanced"
        ;;
    "power-saver")
        icon="󰾆"
        tooltip="Power Saver Mode\nClick to switch"
        class="power-saver"
        ;;
    *)
        icon="󰚥"
        tooltip="Unknown: $profile"
        class=""
        ;;
esac

# Output JSON for Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
