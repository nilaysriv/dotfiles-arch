#!/usr/bin/env bash

# XDG Desktop Portal setup script
# Ensures proper portal configuration for Hyprland

# Update D-Bus activation environment
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Restart portal service to pick up new environment
systemctl --user restart xdg-desktop-portal.service

