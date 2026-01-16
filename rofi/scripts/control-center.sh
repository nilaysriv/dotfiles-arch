#!/usr/bin/env bash

# Control Center main menu
# Five sections: Wallpaper, Theme, Icon Theme, App Visibility, Config Editor

ROFI_THEME="$HOME/.config/rofi/control-center.rasi"

# Menu options
options="󰸉  Wallpaper\n󰏘  Theme Selector\n󰀻  Icon Theme\n󰛔  App Visibility\n󰫮  Edit Configs"

# Show menu
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Control Center" -theme "$ROFI_THEME")

# Execute based on choice
case $chosen in
    "󰸉  Wallpaper")
        "$HOME/.config/rofi/scripts/wallpaper-picker.sh"
        ;;
    "󰏘  Theme Selector")
        "$HOME/.config/rofi/scripts/theme-picker.sh"
        ;;
    "󰀻  Icon Theme")
        "$HOME/.config/rofi/scripts/icon-theme-picker.sh"
        ;;
    "󰛔  App Visibility")
        "$HOME/.config/rofi/scripts/app-visibility.sh"
        ;;
    "󰫮  Edit Configs")
        "$HOME/.config/rofi/scripts/config-editor.sh"
        ;;
esac
