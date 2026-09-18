#!/bin/sh

# rofi menu to select projects and open 
set -euo pipefail

PROJECTS_DIR="$HOME/Projects"
TERMINAL="kitty"

if [ ! -d "$PROJECTS_DIR" ]; then
    notify-send "Rofi Projects" "Directory $PROJECTS_DIR does not exist."
    exit 1
fi

choice="$(
    find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' \
    | sort -rn \
    | cut -d' ' -f2- \
    | sed "s|^$PROJECTS_DIR/||" \
    | rofi -dmenu -i -p "Projects:" -no-show-icons
)"

[ -n "$choice" ] || exit 0

target_path="$PROJECTS_DIR/$choice"

$TERMINAL --directory "$target_path" &
$TERMINAL --directory "$target_path" -e nvim . &



