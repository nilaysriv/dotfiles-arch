#!/usr/bin/env bash
# Flatpak Theme Configuration Script
# This script configures Flatpak applications to use dark themes

set -e

echo "🎨 Configuring Flatpak themes..."

# Apply global Flatpak overrides
echo "  → Unsetting GTK theme override (to use system theme)..."
flatpak override --user --unset-env=GTK_THEME

echo "  → Unsetting Qt style override..."
flatpak override --user --unset-env=QT_STYLE_OVERRIDE

echo "  → Unsetting color scheme preference..."
flatpak override --user --unset-env=COLOR_SCHEME

echo "  → Unsetting GTK2 theme..."
flatpak override --user --unset-env=GTK2_RC_FILES

echo "  → Enabling GTK portal..."
flatpak override --user --env=GTK_USE_PORTAL=1

echo "  → Configuring XDG portal preference..."
flatpak override --user --env=XDG_CURRENT_DESKTOP=KDE

# Grant filesystem access for themes and configs
echo "  → Granting filesystem access for themes..."
flatpak override --user --filesystem=xdg-config/Kvantum:ro
flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro
flatpak override --user --filesystem=~/.themes:ro
flatpak override --user --filesystem=~/.icons:ro

echo ""
echo "✨ Flatpak theme configuration complete!"
echo ""
echo "📦 Installing Kvantum theme engines..."

# Install Kvantum theme engines if not already installed
if ! flatpak list | grep -q "org.kde.KStyle.Kvantum.*5.15"; then
    echo "  → Installing Kvantum for Qt5 (5.15)..."
    flatpak install -y flathub org.kde.KStyle.Kvantum//5.15
else
    echo "  → Kvantum Qt5 already installed ✓"
fi

if ! flatpak list | grep -q "org.kde.KStyle.Kvantum.*6.10"; then
    echo "  → Installing Kvantum for Qt6 (6.10)..."
    flatpak install -y flathub org.kde.KStyle.Kvantum//6.10
else
    echo "  → Kvantum Qt6 already installed ✓"
fi

echo ""
echo "✅ All done! Restart your Flatpak apps for changes to take effect."
