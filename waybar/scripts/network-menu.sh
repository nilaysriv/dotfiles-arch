#!/usr/bin/env bash

# Network Menu - INSTANT launch
# Shows minimal menu, click Scan to see networks

SCAN="${1:-}"

# Get current connection (fast)
CURRENT=$(nmcli -t -f NAME connection show --active 2>/dev/null | head -n1)

# Build menu
menu=""

if [ -n "$CURRENT" ]; then
    menu+="󰈀 Connected: $CURRENT"$'\n'
    menu+="󰌍 Disconnect"$'\n'
else
    menu+="󰖪 Not Connected"$'\n'
fi
menu+="🔄 Scan \u0026 Connect"$'\n'
menu+="---"$'\n'
menu+="󰚦 Turn WiFi Off"$'\n'
menu+="󰓦 Settings"

# Show networks ONLY if scanning
if [ "$SCAN" == "scan" ]; then
    menu=""
    menu+="⏳ Scanning..."$'\n'
    menu+="---"$'\n'
    
    # Show networks
    while IFS=':' read -r ssid signal security active; do
        [[ -z "$ssid" ]] && continue
        
        if [ "$signal" -gt 75 ]; then icon="󰤨"
        elif [ "$signal" -gt 50 ]; then icon="󰤥"
        elif [ "$signal" -gt 25 ]; then icon="󰤢"
        else icon="󰤟"; fi
        
        [[ "$security" =~ WPA|WEP ]] && lock=" 󰌾" || lock=""
        [[ "$active" == "yes" ]] && prefix="󰸞 " || prefix=""
        
        menu+="$prefix$icon $ssid$lock ($signal%)"$'\n'
    done < <(nmcli -t -f SSID,SIGNAL,SECURITY,ACTIVE device wifi 2>/dev/null)
    
    menu+="---"$'\n'
    menu+="← Back"
fi

# Show menu
chosen=$(echo -e "$menu" | rofi -dmenu -i -p "󰖩 WiFi" -theme ~/.config/rofi/network-menu.rasi)

# Handle selection
case "$chosen" in
    "🔄 Scan & Connect")
        exec "$0" scan
        ;;
    "← Back")
        exec "$0"
        ;;
    "󰌍 Disconnect")
        nmcli connection down "$CURRENT"
        ;;
    "󰚦 Turn WiFi Off")
        nmcli radio wifi off
        ;;
    "󰓦 Settings")
        nm-connection-editor &
        ;;
    "󰈀 Connected:"*|"󰖪 Not Connected"|"---"|"⏳ Scanning..."|"")
        exit 0
        ;;
    *)
        ssid=$(echo "$chosen" | sed -E 's/^[󰸞 ]*(󰤨|󰤥|󰤢|󰤟) //; s/ 󰌾//; s/ \([0-9]+%\)$//')
        
        if nmcli connection show | grep -q "^$ssid "; then
            nmcli connection up "$ssid"
        else
            password=$(rofi -dmenu -p "Password for $ssid" -password -theme ~/.config/rofi/network-menu.rasi)
            [[ -n "$password" ]] && nmcli device wifi connect "$ssid" password "$password"
        fi
        ;;
esac


