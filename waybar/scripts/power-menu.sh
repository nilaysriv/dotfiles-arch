#!/usr/bin/env bash

# Power menu using Rofi
# Provides shutdown, reboot, logout, suspend, and lock options

ROFI_THEME="$HOME/.config/rofi/control-center.rasi"

# Power menu options
options="⏻ Shutdown\n󰜉 Reboot\n󰍃 Logout\n󰒲 Suspend\n󰌾 Lock"

# Show menu and get selection
selected=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme "$ROFI_THEME" -markup-rows)

# Execute based on selection
case "$selected" in
    *"Shutdown")
        systemctl poweroff
        ;;
    *"Reboot")
        systemctl reboot
        ;;
    *"Logout")
        hyprctl dispatch exit
        ;;
    *"Suspend")
        systemctl suspend
        ;;
    *"Lock")
        hyprlock || swaylock
        ;;
esac
