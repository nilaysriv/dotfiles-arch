#!/usr/bin/env bash

# Keybindings help menu - Dynamically generated from keybinds.conf
# Displays all available keybindings in a Rofi menu

ROFI_THEME="$HOME/.config/rofi/keybindings.rasi"
KEYBINDS_FILE="$HOME/.config/hypr/keybinds.conf"

# Function to parse keybindings from config
parse_keybinds() {
    local category=""
    local output=""
    
    while IFS= read -r line; do
        # Skip empty lines
        [[ -z "$line" ]] && continue
        
        # Detect category headers (box-drawing comments)
        if [[ "$line" =~ ║[[:space:]]*([^║]+)[[:space:]]*║ ]]; then
            category="${BASH_REMATCH[1]}"
            category=$(echo "$category" | xargs)  # Trim whitespace
            
            # Add category header
            output+="
╔═══════════════════════════════════════════════════════════╗
║$(printf "%-59s" "  $category")║
╚═══════════════════════════════════════════════════════════╝

"
            continue
        fi
        
        # Parse bind lines
        if [[ "$line" =~ ^[[:space:]]*bind[em]?[[:space:]]*=[[:space:]]*([^,]+),[[:space:]]*([^,]+),[[:space:]]*(.*) ]]; then
            local modifiers="${BASH_REMATCH[1]}"
            local key="${BASH_REMATCH[2]}"
            local action="${BASH_REMATCH[3]}"
            
            # Skip submaps (resize mode internals)
            [[ "$action" == "submap"* ]] && continue
            
            # Clean up the modifiers
            modifiers=$(echo "$modifiers" | sed 's/\$mainMod/Win/g')
            modifiers=$(echo "$modifiers" | sed 's/SUPER/Win/g')
            modifiers=$(echo "$modifiers" | sed 's/ALT/Alt/g')
            modifiers=$(echo "$modifiers" | sed 's/SHIFT/Shift/g')
            modifiers=$(echo "$modifiers" | sed 's/CTRL/Ctrl/g')
            
            # Format key
            key=$(echo "$key" | sed 's/Return/Return/; s/Escape/Escape/')
            
            # Extract description from action (prefer comments on the same line)
            local description=""
            # Check if line contains a comment
            if echo "$line" | grep -q '#'; then
                description=$(echo "$line" | sed 's/.*#[[:space:]]*//')
            else
                # Try to infer from action
                if [[ "$action" =~ exec,[[:space:]]*(.+) ]]; then
                    local cmd="${BASH_REMATCH[1]}"
                    description=$(basename "$cmd" | sed 's/\.sh$//')
                elif [[ "$action" =~ killactive ]]; then
                    description="Close window"
                elif [[ "$action" =~ togglefloating ]]; then
                    description="Toggle floating"
                elif [[ "$action" =~ fullscreen ]]; then
                    description="Toggle fullscreen"
                elif [[ "$action" =~ workspace,[[:space:]]*([0-9]+) ]]; then
                    description="Switch to workspace ${BASH_REMATCH[1]}"
                elif [[ "$action" =~ movetoworkspace,[[:space:]]*([0-9]+) ]]; then
                    description="Move to workspace ${BASH_REMATCH[1]}"
                elif [[ "$action" =~ movefocus,[[:space:]]*([lrud]) ]]; then
                    description="Move focus ${BASH_REMATCH[1]}"
                elif [[ "$action" =~ movewindow,[[:space:]]*([lrud]) ]]; then
                    description="Move window ${BASH_REMATCH[1]}"
                else
                    description="$action"
                fi
            fi
            
            # Build keybind string
            local keybind=""
            if [[ -n "$modifiers" ]]; then
                keybind="$modifiers + $key"
            else
                keybind="$key"
            fi
            
            # Format output (pad keybind to 28 chars)
            output+="  $(printf "%-28s" "$keybind")$description"$'\n'
        fi
    done < "$KEYBINDS_FILE"
    
    echo "$output"
}

# Generate and display keybindings
keybindings=$(parse_keybinds)

echo "$keybindings" | rofi -dmenu -i -p "Keybindings Help (Auto-generated)" -theme "$ROFI_THEME"
