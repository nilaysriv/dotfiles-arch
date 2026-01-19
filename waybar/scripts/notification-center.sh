#!/bin/bash

# Notification Center - Display dunst notification history with clear button

# Get notification count
count=$(dunstctl count waiting)

# Build notification list with clear button at top
if [ "$count" -gt 0 ]; then
    notifications=$(dunstctl history | jq -r '.data[][] | "\(.appname.data): \(.summary.data) - \(.body.data)"')
    # Add clear button as first option
    menu="󰎟 Clear All Notifications\n$notifications"
else
    menu="No notifications"
fi

# Show in rofi and get selection
selection=$(echo -e "$menu" | rofi -dmenu -theme ~/.config/rofi/notification-center.rasi -p "Notifications ($count)")

# Handle selection
if [ "$selection" = "󰎟 Clear All Notifications" ]; then
    dunstctl history-clear
    notify-send "Notification Center" "All notifications cleared"
fi
