#!/usr/bin/env bash

# XDG Desktop Portal setup script
# Ensures proper portal configuration for Hyprland with KDE integration

# Kill existing portals
killall xdg-desktop-portal-hyprland 2>/dev/null
killall xdg-desktop-portal-kde 2>/dev/null
killall xdg-desktop-portal 2>/dev/null

sleep 1

# Start portals with proper configuration
# Use Hyprland portal for screenshots and screen sharing
# Use KDE portal for file chooser and other KDE-specific tasks
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Start the main portal daemon
/usr/lib/xdg-desktop-portal &

sleep 1

# Start Hyprland-specific portal
/usr/lib/xdg-desktop-portal-hyprland &
