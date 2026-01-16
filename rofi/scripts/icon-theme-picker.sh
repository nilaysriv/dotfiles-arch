#!/usr/bin/env bash

# Icon theme picker
# Allows selecting from installed icon themes

ROFI_THEME="$HOME/.config/rofi/control-center.rasi"

# Get list of installed icon themes
icon_themes=$(find /usr/share/icons ~/.local/share/icons ~/.icons -maxdepth 1 -type d 2>/dev/null | \
    xargs -I {} basename {} | grep -v "^icons$" | sort -u)

# Show selection menu
selected=$(echo "$icon_themes" | rofi -dmenu -i -p "Select Icon Theme" -theme "$ROFI_THEME")

if [ -z "$selected" ]; then
    exit 0
fi

# Apply icon theme using gsettings (GTK)
gsettings set org.gnome.desktop.interface icon-theme "$selected"

# Apply to Qt apps via qt5ct/qt6ct config
QT5CT_CONF="$HOME/.config/qt5ct/qt5ct.conf"
QT6CT_CONF="$HOME/.config/qt6ct/qt6ct.conf"

if [ -f "$QT5CT_CONF" ]; then
    sed -i "s/^icon_theme=.*/icon_theme=$selected/" "$QT5CT_CONF"
fi

if [ -f "$QT6CT_CONF" ]; then
    sed -i "s/^icon_theme=.*/icon_theme=$selected/" "$QT6CT_CONF"
fi

# Update Rofi icon theme in app launcher
sed -i "s/icon-theme: \".*\";/icon-theme: \"$selected\";/" "$HOME/.config/rofi/app-launcher.rasi"

# Notify user
notify-send "Icon Theme" "Applied: $selected\nNote: Some apps may need to be restarted"
