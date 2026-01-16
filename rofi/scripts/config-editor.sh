#!/usr/bin/env bash

# Config editor - quick access to edit configuration files with nano

ROFI_THEME="$HOME/.config/rofi/control-center.rasi"
EDITOR="nano"

# Configuration files
configs="Hyprland Main:$HOME/.config/hypr/hyprland.conf
Keybindings:$HOME/.config/hypr/keybinds.conf
Window Rules:$HOME/.config/hypr/rules.conf
Autostart:$HOME/.config/hypr/autostart.conf
Animations:$HOME/.config/hypr/animations.conf
Waybar Config:$HOME/.config/waybar/config.json
Waybar Style:$HOME/.config/waybar/style.css
Rofi App Launcher:$HOME/.config/rofi/app-launcher.rasi
Hyprlock:$HOME/.config/hypr/hyprlock.conf
Hypridle:$HOME/.config/hypr/hypridle.conf"

# Display menu
selection=$(echo "$configs" | awk -F: '{print $1}' | rofi -dmenu -i -p "Edit Config" -theme "$ROFI_THEME")

# Get selected file path
if [ -n "$selection" ]; then
    file=$(echo "$configs" | grep "^$selection:" | awk -F: '{print $2}')
    
    if [ -f "$file" ]; then
        kitty -e $EDITOR "$file"
    else
        notify-send "Config Editor" "File not found: $file" -u critical
    fi
fi
