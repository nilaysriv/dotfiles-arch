#!/usr/bin/env bash

# XDG Desktop Portal setup script for Hyprland with KDE integration
# Ensures proper portal setup for file dialogs, AppChooser (Open With), etc.

sleep 1

# Kill ALL portal processes (including rogue ones started via D-Bus activation)
pkill -9 -f "xdg-desktop-portal" 2>/dev/null || true
sleep 1

# Stop systemd services cleanly
systemctl --user stop xdg-desktop-portal.service 2>/dev/null || true
systemctl --user stop xdg-desktop-portal-hyprland.service 2>/dev/null || true
systemctl --user stop xdg-desktop-portal-gtk.service 2>/dev/null || true
systemctl --user stop plasma-xdg-desktop-portal-kde.service 2>/dev/null || true

sleep 1

# Update activation environment for D-Bus - MUST include XDG_MENU_PREFIX for KDE apps!
export XDG_MENU_PREFIX=plasma-
dbus-update-activation-environment --systemd \
    WAYLAND_DISPLAY \
    XDG_CURRENT_DESKTOP \
    XDG_SESSION_TYPE \
    XDG_MENU_PREFIX

systemctl --user import-environment \
    WAYLAND_DISPLAY \
    XDG_CURRENT_DESKTOP \
    XDG_SESSION_TYPE \
    XDG_MENU_PREFIX

# Rebuild KDE service cache with correct prefix
kbuildsycoca6 --noincremental 2>/dev/null &

sleep 1

# Start portals via systemd in correct order:
# 1. Main portal service (Host) - Must run first so backends can register!
# 2. KDE portal (provides AppChooser for "Open With" in Dolphin)
# 3. Hyprland portal (provides Screenshot/ScreenCast)

systemctl --user start xdg-desktop-portal.service
sleep 2
systemctl --user start plasma-xdg-desktop-portal-kde.service
sleep 1
systemctl --user start xdg-desktop-portal-hyprland.service