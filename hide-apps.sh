#!/bin/bash

# List of desktop files
APPS_TO_HIDE=(
    "xgps.desktop"
    "xgpsspeed.desktop"
    "rofi.desktop"
    "rofi-theme-selector.desktop"
    "qv4l2.desktop"
    "qvidcap.desktop"
    "jshell-java-openjdk.desktop"
    "jconsole-java-openjdk.desktop"
    "bssh.desktop"
    "bvnc.desktop"
    "nm-connection-editor.desktop"
    # Avahi Zeroconf Browser
    "avahi-discover.desktop"
    # Qt Development Tools
    "assistant.desktop"
    "designer.desktop"
    "linguist.desktop"
    "qdbusviewer.desktop"
)

TARGET_DIR="$HOME/.local/share/applications"
mkdir -p "$TARGET_DIR"

echo "Hiding unnecessary entries from Rofi..."

for app in "${APPS_TO_HIDE[@]}"; do
    if [ -f "/usr/share/applications/$app" ]; then
        cp "/usr/share/applications/$app" "$TARGET_DIR/"
        if grep -q "NoDisplay=" "$TARGET_DIR/$app"; then
            sed -i 's/NoDisplay=.*/NoDisplay=true/' "$TARGET_DIR/$app"
        else
            echo "NoDisplay=true" >> "$TARGET_DIR/$app"
        fi
        echo "[✓] Hidden: $app"
    else
        echo "[!] Warning: $app not found in /usr/share/applications/"
    fi
done
