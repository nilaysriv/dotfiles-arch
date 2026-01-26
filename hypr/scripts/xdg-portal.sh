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


dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
