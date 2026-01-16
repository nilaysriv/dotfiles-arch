# Hyprland Configuration for Arch Linux with KDE Integration

A comprehensive, modular Hyprland configuration designed to integrate seamlessly with KDE Plasma applications while providing a modern, fast, and customizable Wayland experience.

## ✨ Features

- **🎨 29 Built-in Themes** - Catppuccin, Nord, Gruvbox, Dracula, Tokyo Night, Rose Pine, and many more
- **🖼️ Dynamic Wallpaper Theming** - Pywal integration to generate themes from your wallpaper
- **⚡ Fast Animations** - Sharp corners, no blur, snappy performance
- **🎯 KDE Integration** - Full compatibility with Dolphin, KDE Connect, and other KDE apps
- **📊 Feature-Rich Waybar** - 10 customizable modules with click interactions
- **🚀 Rofi Launchers** - Beautiful app launcher and control center
- **🔧 Modular Configuration** - Easy to customize and maintain
- **📝 Comprehensive Documentation** - Inline comments in all config files

## 📋 Requirements

### Core Dependencies
```bash
hyprland waybar rofi-wayland dunst hyprlock hypridle
swww python-pywal blueman networkmanager
brightnessctl pamixer bluez bluez-utils
btop kitty playerctl pavucontrol wl-clipboard cliphist
```

### Fonts
```bash
ttf-jetbrains-mono ttf-jetbrains-mono-nerd
noto-fonts noto-fonts-emoji
```

### Optional (AUR)
```bash
waypaper hyprpicker
```

## 🚀 Installation

1. **Run the installation script** (installs all dependencies):
```bash
cd ~/.config/hypr
./install.sh
```

2. **Log out and select Hyprland** from your display manager

3. **Configure your setup**:
   - Press `Win + Alt + Space` to open the Control Center
   - Select a theme, wallpaper, and icon theme
   - Customize keybindings in `~/.config/hypr/keybinds.conf`

## ⌨️ Keybindings

### Main Shortcuts
| Keybinding | Action |
|------------|--------|
| `Win + Space` | Open application launcher (Rofi) |
| `Win + Alt + Space` | Open control center |
| `Win + F1` | Show keybindings help |
| `Win + Return` | Open terminal (Kitty) |
| `Win + E` | Open file manager (Dolphin) |
| `Win + Q` | Close active window |
| `Win + F` | Toggle fullscreen |
| `Win + V` | Toggle floating mode |
| `Win + X` | Lock screen |
| `Win + Escape` | Power menu |

### Window Management
| Keybinding | Action |
|------------|--------|
| `Win + ←/→/↑/↓` | Move focus |
| `Win + Shift + ←/→/↑/↓` | Move window |
| `Win + H/J/K/L` | Move focus (vim keys) |
| `Win + Shift + H/J/K/L` | Move window (vim keys) |
| `Win + R` | Enter resize mode |

### Workspaces
| Keybinding | Action |
|------------|--------|
| `Win + 1-9, 0` | Switch to workspace 1-10 |
| `Win + Shift + 1-9, 0` | Move window to workspace |
| `Win + Ctrl + ←/→` | Previous/next workspace |
| `Win + S` | Toggle scratchpad |

### Media Keys
| Keybinding | Action |
|------------|--------|
| `XF86AudioRaiseVolume` | Increase volume |
| `XF86AudioLowerVolume` | Decrease volume |
| `XF86AudioMute` | Mute audio |
| `XF86MonBrightnessUp` | Increase brightness |
| `XF86MonBrightnessDown` | Decrease brightness |
| `XF86AudioPlay/Pause` | Play/pause media |

### Screenshots
| Keybinding | Action |
|------------|--------|
| `Win + Shift + S` | Screenshot area (select with mouse) |
| `Print` | Screenshot full screen |
| `Win + Print` | Screenshot current window |

## 📊 Waybar Modules

The top bar includes 10 modules with interactive features:

1. **Workspaces** - Click to switch workspaces
2. **Clock** - Click to toggle between time and date
3. **CPU Usage** - Click to open btop
4. **RAM Usage** - Click to toggle between percentage and actual memory
5. **Bluetooth** - Click to open Blueman manager
6. **WiFi** - Click to open Network Manager
7. **Sound** - Click to mute, right-click for PulseAudio control
8. **Brightness** - Scroll to adjust
9. **System Tray** - Application indicators
10. **Power Menu** - Lock, suspend, logout, reboot, shutdown, reload Hyprland

## 🎨 Themes

### Available Themes (29)

**Catppuccin Family**
- Latte (light) | Frappé (dark) | Macchiato (dark) | Mocha (dark)

**Popular Themes**
- Nord | Gruvbox (dark/light) | Solarized (dark/light)
- Dracula | Tokyo Night | Rose Pine (dawn/moon/base)
- Everforest | Kanagawa | One Dark/Light
- Monokai Pro | Ayu (light/mirage/dark)
- Oxocarbon | Night Owl | Material Palenight
- SynthWave '84 | Tomorrow Night | Forest Night
- PaperColor | Zenburn

**Dynamic Theme**
- Pywal - Generates colors from your wallpaper

### Switching Themes

1. **Via Control Center**:
   - Press `Win + Alt + Space`
   - Select "Theme Selector"
   - Choose your theme

2. **Via Command Line**:
   ```bash
   ~/.config/rofi/scripts/theme-picker.sh
   ```

3. **Enable Pywal** (dynamic wallpaper theming):
   ```bash
   ~/.config/hypr/scripts/pywal-integration.sh
   ```

## 🖼️ Wallpaper Management

### Changing Wallpaper

1. **Via Control Center**:
   - Press `Win + Alt + Space`
   - Select "Wallpaper"
   - Choose wallpaper in Waypaper GUI

2. **Via Command Line**:
   ```bash
   waypaper
   ```

### Setting Default Wallpaper

Place your default wallpaper at:
```
~/Pictures/wallpapers/default.jpg
```

## 🎯 Control Center

Press `Win + Alt + Space` to access the control center with 5 sections:

1. **🖼️ Wallpaper** - Open Waypaper GUI
2. **🎨 Theme Selector** - Choose from 29 themes
3. **🎭 Icon Theme** - Select installed icon theme
4. **👁️ App Visibility** - Hide/show apps in launcher
5. **📝 Edit Configs** - Quick access to edit configuration files with nano

## 📁 Configuration Structure

```
~/.config/hypr/
├── hyprland.conf          # Main configuration (imports all others)
├── keybinds.conf          # Keyboard shortcuts
├── rules.conf             # Window rules for KDE apps
├── autostart.conf         # Startup applications
├── animations.conf        # Fast animations
├── theme.conf             # Current theme colors (auto-generated)
├── hypridle.conf          # Idle management
├── hyprlock.conf          # Lock screen appearance
├── install.sh             # Dependency installation script
├── scripts/
│   ├── pywal-integration.sh    # Pywal theme generator
│   ├── wallpaper-init.sh       # Wallpaper initialization
│   └── xdg-portal.sh           # XDG portal setup
└── themes/
    └── theme-definitions.json  # All theme definitions

~/.config/waybar/
├── config.json            # Waybar modules configuration
├── style.css              # Waybar styling (theme-aware)
└── scripts/
    ├── cpu-usage.sh       # CPU monitoring
    ├── ram-usage.sh       # RAM monitoring
    ├── ram-toggle.sh      # Toggle RAM display mode
    └── power-menu.sh      # Power menu

~/.config/rofi/
├── app-launcher.rasi      # App launcher theme
├── control-center.rasi    # Control center theme
├── power-menu.rasi        # Power menu theme
├── hidden-apps.txt        # List of hidden apps
└── scripts/
    ├── app-launcher.sh         # App launcher with filtering
    ├── control-center.sh       # Control center main menu
    ├── theme-picker.sh         # Theme selection
    ├── icon-theme-picker.sh    # Icon theme selection
    ├── wallpaper-picker.sh     # Wallpaper launcher
    ├── app-visibility.sh       # Hide/show apps
    └── config-editor.sh        # Quick config editor
```

## 🔧 Customization

### Adding Custom Colors

Edit the active theme in `~/.config/hypr/theme.conf` or create a new theme in `~/.config/hypr/themes/theme-definitions.json`.

### Modifying Animations

Edit `~/.config/hypr/animations.conf`:
```conf
# Change animation speed (lower = faster)
animation = windows, 1, 3, fast, slide  # Change 3 to desired duration
```

### Changing Terminal

Edit `~/.config/hypr/keybinds.conf`:
```conf
$terminal = your-preferred-terminal
```

### Adding Startup Applications

Edit `~/.config/hypr/autostart.conf`:
```conf
exec-once = your-application
```

### Excluding Apps from System Tray

The configuration already excludes NetworkManager and Blueman applets since Waybar has dedicated modules. To hide other apps, they typically have their own settings.

## 🐛 Troubleshooting

### Waybar not showing
```bash
killall waybar
waybar &
```

### Wallpaper not loading
```bash
swww-daemon &
swww img /path/to/your/wallpaper.jpg
```

### Theme not applying
```bash
hyprctl reload
```

### KDE apps not themed properly
```bash
export QT_QPA_PLATFORMTHEME=qt5ct  # or kvantum
qt5ct  # Configure Qt theme
```

### Screen lock not working
```bash
systemctl --user restart hypridle
```

## 📖 Additional Resources

- **Hyprland Wiki**: https://wiki.hyprland.org/
- **Waybar Documentation**: https://github.com/Alexays/Waybar/wiki
- **Rofi Documentation**: https://github.com/davatorium/rofi
- **Theme Inspirations**: https://github.com/catppuccin, https://github.com/nordtheme

## 🙏 Credits

- **Hyprland** - vaxerski
- **Waybar** - Alexays
- **Rofi** - davatorium
- **Themes** - Various community theme creators
- **JetBrains Mono** - JetBrains

## 📝 License

This configuration is provided as-is for personal use. Individual components retain their original licenses.

---

**Enjoy your Hyprland setup! 🚀**

For issues or contributions, feel free to modify and share this configuration.
