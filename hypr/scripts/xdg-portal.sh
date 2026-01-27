#!/usr/bin/env bash

# XDG Desktop Portal setup script for Hyprland with KDE integration
# Ensures KDE portal is used for file dialogs and other portal interfaces

# Update D-Bus activation environment
#dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
#systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Stop any conflicting portal implementations
#systemctl --user stop xdg-desktop-portal-gtk.service 2>/dev/null || true

# Restart portal services in correct order
#systemctl --user restart xdg-desktop-portal-kde.service
#systemctl --user restart xdg-desktop-portal-hyprland.service
#systemctl --user restart xdg-desktop-portal.service


#dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
#systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
sleep 1
# Kill all possible running portals
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-kde
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal

# Update activation environment for D-Bus
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Start the portals
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
dunst & # Start dunst after environment is ready
