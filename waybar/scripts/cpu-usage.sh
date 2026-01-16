#!/usr/bin/env bash

# CPU usage script for Waybar
# Displays CPU usage percentage and provides tooltip with per-core usage

# Get overall CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
cpu_int=$(printf "%.0f" "$cpu_usage")

# Get per-core usage for tooltip
cores=$(mpstat -P ALL 1 1 | awk '/Average/ && $2 ~ /[0-9]/ {printf "Core %s: %.1f%%\n", $2, 100-$NF}')

# Determine status class for Waybar
if [ "$cpu_int" -gt 80 ]; then
    class="critical"
elif [ "$cpu_int" -gt 60 ]; then
    class="warning"
else
    class=""
fi

# Output for Waybar
echo "{\"text\":\"$cpu_int\", \"tooltip\":\"CPU Usage: ${cpu_usage}%\n\n${cores}\", \"class\":\"$class\"}"
