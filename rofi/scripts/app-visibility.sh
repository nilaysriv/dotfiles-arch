#!/usr/bin/env bash

# App visibility toggle
# Add or remove applications from the hidden apps list

ROFI_THEME="$HOME/.config/rofi/app-launcher.rasi"
HIDDEN_APPS_FILE="$HOME/.config/rofi/hidden-apps.txt"

# Create hidden apps file if it doesn't exist
touch "$HIDDEN_APPS_FILE"

# Get list of all installed applications
all_apps=$(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null | \
    xargs -I {} basename {} .desktop | sort -u)

# Menu options
options="Show Hidden Apps\nHide Application"

action=$(echo -e "$options" | rofi -dmenu -i -p "App Visibility" -theme "$ROFI_THEME")

case $action in
    "Show Hidden Apps")
        # Show currently hidden apps and allow unhiding
        if [ -s "$HIDDEN_APPS_FILE" ]; then
            app=$(cat "$HIDDEN_APPS_FILE" | rofi -dmenu -i -p "Unhide App" -theme "$ROFI_THEME")
            if [ -n "$app" ]; then
                # Remove from hidden list
                sed -i "/^${app}$/d" "$HIDDEN_APPS_FILE"
                notify-send "App Visibility" "Unhidden: $app"
            fi
        else
            notify-send "App Visibility" "No hidden apps"
        fi
        ;;
    "Hide Application")
        # Show all apps and allow hiding
        app=$(echo "$all_apps" | rofi -dmenu -i -p "Hide App" -theme "$ROFI_THEME")
        if [ -n "$app" ]; then
            # Check if already hidden
            if grep -Fxq "$app" "$HIDDEN_APPS_FILE"; then
                notify-send "App Visibility" "$app is already hidden"
            else
                # Add to hidden list
                echo "$app" >> "$HIDDEN_APPS_FILE"
                notify-send "App Visibility" "Hidden: $app"
            fi
        fi
        ;;
esac
