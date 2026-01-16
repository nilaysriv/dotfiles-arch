#!/usr/bin/env bash

# RAM usage script for Waybar
# Toggleable between percentage and actual memory usage (GB)

STATE_FILE="$HOME/.cache/ram-display-mode"

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "percentage" > "$STATE_FILE"
fi

# Read current display mode
MODE=$(cat "$STATE_FILE")

# Get memory information
mem_info=$(free -m | awk 'NR==2')
total=$(echo "$mem_info" | awk '{print $2}')
used=$(echo "$mem_info" | awk '{print $3}')
available=$(echo "$mem_info" | awk '{print $7}')

# Calculate percentage
percentage=$(awk "BEGIN {printf \"%.0f\", ($used/$total)*100}")

# Display based on mode
if [ "$MODE" = "percentage" ]; then
    output="${percentage}%"
else
    # Display in GB
    used_gb=$(awk "BEGIN {printf \"%.1f\", $used/1024}")
    total_gb=$(awk "BEGIN {printf \"%.1f\", $total/1024}")
    output="${used_gb}G/${total_gb}G"
fi

# Create tooltip
tooltip="RAM Usage\n\nUsed: ${used}M (${percentage}%)\nTotal: ${total}M\nAvailable: ${available}M\n\nClick to toggle display mode"

# Output for Waybar
echo "{\"text\":\"$output\", \"tooltip\":\"$tooltip\"}"
