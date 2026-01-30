# Arch Linux + Hyprland Dotfiles

My Personal Configuration for Arch Linux using the Hyprland compositor.
Pretty Lightweight and looks good too :)

## Gallery

![Dots](Screenshots/1.png)
![Dots](Screenshots/2.png)
![Dots](Screenshots/3.png)
![Dots](Screenshots/4.png)

---

## Components

| Component         | Application                                                        |
| ----------------- | ------------------------------------------------------------------ |
| **OS**            | Arch Linux                                                         |
| **Compositor**    | [Hyprland](https://hyprland.org)                                   |
| **Terminal**      | [Kitty](https://sw.kovidgoyal.net/kitty/)                          |
| **Shell**         | Zsh                                                                |
| **Bar**           | [Waybar](https://github.com/Alexays/Waybar)                        |
| **Launcher**      | [Rofi](https://github.com/davatorium/rofi)                         |
| **Notifications** | [Dunst](https://dunst-project.org/)                                |
| **Lock Screen**   | Hyprlock                                                           |
| **Idle Daemon**   | Hypridle                                                           |
| **Wallpaper**     | swww / [Waypaper](https://github.com/anufrievroman/waypaper)       |
| **File Manager**  | Dolphin                                                            |
| **GTK Settings**  | [nwg-look](https://github.com/nwg-piotr/nwg-look)                  |
| **Blue Light**    | [hyprsunset](https://wiki.hyprland.org/Hypr-Ecosystem/hyprsunset/) |

---

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles-arch.git
cd dotfiles-arch
```

### 2. Install Packages

The `package_list.txt` contains all necessary packages.

```bash
# Using pacman (requires root/sudo)
sudo pacman -S --needed - < package_list.txt

# Or if you use an AUR helper like yay
yay -S --needed - < package_list.txt
```

### 3. Apply Configurations

**Backup your existing configs first!**

```bash
# Example backup
mkdir ~/config_backup
mv ~/.config/hypr ~/config_backup/
mv ~/.config/waybar ~/config_backup/
# ... repeat for others
```

Copy the configuration folders to your local `.config` directory:

```bash
# Copy main configs
cp -r hypr waybar rofi dunst kitty fastfetch Kvantum qt5ct qt6ct nwg-look ~/.config/

# Copy miscellaneous configs
cp -r gnome-disk-utility gtk-3.0 gtk-4.0 xdg-desktop-portal wlatout ~/.config/

# Copy Zsh config
cp .zshrc ~/.zshrc
```

### 4. Setup Theme & Appearance

1. **Flatpak Themes**: If you use Flatpak apps, run the setup script to match them with your system theme (Adwaita-dark/Kvantum).
   ```bash
   ./setup-flatpak-themes.sh
   ```
2. **GTK/Qt**: Open `nwg-look` to set GTK themes and `qt5ct`/`qt6ct` for Qt theming.

---

## Keybindings

Most keybindings use `SUPER` (Windows Key) as the main modifier. See `hypr/keybinds.conf` for the full list.

| Key                      | Action                  |
| ------------------------ | ----------------------- |
| `SUPER` + `Return` / `T` | Open Terminal (Kitty)   |
| `SUPER` + `F1`           | Open Keybinds list      |
| `SUPER` + `Space`        | App Launcher (Rofi)     |
| `SUPER` + `E`            | File Manager (Nautilus) |
| `SUPER` + `B`            | Open Browser            |
| `SUPER` + `Q`            | Close Active Window     |
| `SUPER` + `V`            | Toggle Floating Window  |
| `SUPER` + `F`            | Toggle Fullscreen       |
| `Print`                  | Screenshot Area         |
| `SUPER` + `Print`        | Screenshot Fullscreen   |
| `SUPER` + `X`            | Lock Screen             |

---

## Color Schemes available

```
Catppuccin Latte
Catppuccin Frappé
Catppuccin Macchiato
Catppuccin Mocha
Nord
Gruvbox Dark
Gruvbox Light
Solarized Dark
Solarized Light
Dracula
Tokyo Night
Rose Pine Base
Rose Pine Moon
Rose Pine Dawn
Everforest
Kanagawa
One Dark
One Light
Monokai Pro
Ayu Light
Ayu Mirage
Ayu Dark
Oxocarbon
Night Owl
Material Palenight
SynthWave '84
Tomorrow Night
Forest Night
PaperColor
Zenburn
Monochrome
Poimandres
Aura Dark
Shades of Purple
Blood
Minimal Kiwi
```

## Theme Switcher

This configuration comes with a custom theme switcher that updates Hyprland, Waybar, Rofi, Kitty, and Dunst on the fly.

- **Launch**: Run `rofi/scripts/theme-picker.sh` (or bind it to a key).
- **Function**: Select a theme from the menu to instantly apply colors across all components.
- **Pywal**: Includes integration for generating colors from your wallpaper.

---

## Utility Scripts

### Hide Apps

`hide-apps.sh` helps declutter your application menu (Rofi) by hiding unnecessary desktop entries (like individual Qt tools or helper apps).

```bash
./hide-apps.sh
```

### Flatpak Themes

`setup-flatpak-themes.sh` ensures your Flatpak applications respect your system's dark mode and styling (using Kvantum and Adwaita-dark).

```bash
./setup-flatpak-themes.sh
```

---

## Directory Structure

- `hypr/`: Hyprland configuration (animations, monitors, rules, themes).
- `waybar/`: Status bar configuration and style.
- `rofi/`: App launcher themes and scripts.
- `dunst/`: Notification daemon settings.
- `kitty/`: Terminal configuration.
- `fastfetch/`: System information fetch tool config.
- `flatpak/`: Flatpak specific overrides.
- `Kvantum/`, `qt5ct/`, `qt6ct/`: Qt theming configurations.
- `nwg-look/`: GTK settings.

---
