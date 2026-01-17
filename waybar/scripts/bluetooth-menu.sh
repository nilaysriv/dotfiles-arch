#!/usr/bin/env bash

# Bluetooth Menu Script for Waybar
# Shows Bluetooth devices in a rofi dropdown

# Check if bluetooth is on
BT_STATUS=$(bluetoothctl show | grep "Powered: yes")

menu_entries=()

if [ -z "$BT_STATUS" ]; then
    menu_entries+=("󰂲 Bluetooth Off")
    menu_entries+=("󰂯 Turn Bluetooth On")
else
    menu_entries+=("󰂯 Bluetooth On")
    menu_entries+=("󰂲 Turn Bluetooth Off")
    menu_entries+=("---")
    menu_entries+=("󰑐 Paired Devices")
    
    # Get paired devices
    while IFS=$'\n' read -r device; do
        mac=$(echo "$device" | awk '{print $2}')
        name=$(echo "$device" | sed 's/^Device [^ ]* //')
        
        # Check if connected
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            menu_entries+=("󰂱 $name [Connected]")
        else
            menu_entries+=("󰂯 $name [Paired]")
        fi
    done < <(bluetoothctl devices Paired)
    
    menu_entries+=("---")
    menu_entries+=("󰐇 Available Devices")
    
    # Get available devices (from cache, no scan delay)
    while IFS=$'\n' read -r device; do
        mac=$(echo "$device" | awk '{print $2}')
        name=$(echo "$device" | sed 's/^Device [^ ]* //')
        
        # Skip if already paired
        if ! bluetoothctl devices Paired | grep -q "$mac"; then
            menu_entries+=("󰾆 $name")
        fi
    done < <(bluetoothctl devices)
    
    menu_entries+=("---")
    menu_entries+=("󰓦 Settings")
fi

# Display menu
printf '%s\n' "${menu_entries[@]}" | rofi -dmenu -i -p "󰂯 Bluetooth" -theme ~/.config/rofi/bluetooth-menu.rasi | {
    read -r chosen
    
    if [ -z "$chosen" ]; then
        exit 0
    fi
    
    case "$chosen" in
        "󰂯 Turn Bluetooth On")
            bluetoothctl power on
            ;;
        "󰂲 Turn Bluetooth Off")
            bluetoothctl power off
            ;;
        "󰓦 Settings")
            blueman-manager &
            ;;
        "󰑐 Paired Devices"|"󰐇 Available Devices"|"---"|"󰂲 Bluetooth Off"|"󰂯 Bluetooth On")
            # Header items, ignore
            ;;
        󰂱*)
            # Connected device - disconnect
            name=$(echo "$chosen" | sed 's/󰂱 //' | sed 's/ \[Connected\]//')
            mac=$(bluetoothctl devices Paired | grep "$name" | awk '{print $2}')
            bluetoothctl disconnect "$mac"
            ;;
        󰂯*)
            # Paired but not connected - connect
            name=$(echo "$chosen" | sed 's/󰂯 //' | sed 's/ \[Paired\]//')
            mac=$(bluetoothctl devices Paired | grep "$name" | awk '{print $2}')
            bluetoothctl connect "$mac"
            ;;
        󰾆*)
            # New device - pair and connect
            name=$(echo "$chosen" | sed 's/󰾆 //')
            mac=$(bluetoothctl devices | grep "$name" | awk '{print $2}')
            bluetoothctl pair "$mac" && bluetoothctl connect "$mac"
            ;;
    esac
}
