#!/bin/bash

CONFIG_FILE="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
BACKUP_DIR="$HOME/.kde-icon-backups"

# Function to capture icon layout
function capture_layout() {
    mkdir -p "$BACKUP_DIR"
    BACKUP_FILE="$BACKUP_DIR/desktop-icons-$(date +'%Y-%m-%d_%H-%M-%S').bak"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo "Icon layout saved successfully in: $BACKUP_FILE"
}

# Function to restore icon layout
function restore_layout() {
    echo "Available backup files:"
    select file in "$BACKUP_DIR"/*.bak; do
        if [ -n "$file" ]; then
            cp "$file" "$CONFIG_FILE"
            echo "Icon layout restored from: $file"
            echo "Restarting KDE Plasma shell..."
            kquitapp5 plasmashell && kstart5 plasmashell
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

# Interactive menu
function show_menu() {
    PS3="Please choose an option (1, 2, or 3): "
    options=("Capture icon layout" "Restore icon layout" "Exit")
    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                capture_layout
                break
                ;;
            2)
                restore_layout
                break
                ;;
            3)
                echo "Exiting script."
                break
                ;;
            *)
                echo "Invalid option. Please choose 1, 2, or 3."
                ;;
        esac
    done
}

# Run the menu
show_menu
