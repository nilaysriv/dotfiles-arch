#!/usr/bin/env bash

# XDG Desktop Portal setup script for Hyprland with KDE integration
# Ensures proper portal setup for file dialogs, AppChooser (Open With), etc.

sleep 1

# Stop any manually running portals and systemd services
killall -e xdg-desktop-portal-hyprland 2>/dev/null || true
killall -e xdg-desktop-portal-kde 2>/dev/null || true
killall -e xdg-desktop-portal-gtk 2>/dev/null || true
killall -e xdg-desktop-portal 2>/dev/null || true

systemctl --user stop xdg-desktop-portal.service 2>/dev/null || true
systemctl --user stop xdg-desktop-portal-hyprland.service 2>/dev/null || true
systemctl --user stop xdg-desktop-portal-gtk.service 2>/dev/null || true
systemctl --user stop plasma-xdg-desktop-portal-kde.service 2>/dev/null || true

sleep 1

# Update activation environment for D-Bus
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

# Start portals via systemd in correct order:
# 1. Main portal service (Host) - Must run first so backends can register!
# 2. KDE portal (provides AppChooser for "Open With" in Dolphin)
# 3. Hyprland portal (provides Screenshot/ScreenCast)

systemctl --user start xdg-desktop-portal.service
sleep 1
systemctl --user start plasma-xdg-desktop-portal-kde.service
sleep 1
systemctl --user start xdg-desktop-portal-hyprland.service