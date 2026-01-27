#!/usr/bin/env bash

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
