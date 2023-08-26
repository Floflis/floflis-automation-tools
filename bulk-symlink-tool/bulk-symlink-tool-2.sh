#!/bin/bash

# Function to add custom content before symlink addresses
add_prefix_to_symlinks() {
    local prefix="$1"
    local folder="$2"

    find "$folder" -maxdepth 1 -type l -exec sh -c '
        for symlink do
            target=$(readlink "$symlink")
            new_target="$prefix$target"
            ln -sf "$new_target" "$symlink"
        done
    ' sh {} +
}

# Main script
if [ $# -lt 1 ]; then
    echo "Usage: $0 <prefix>"
    exit 1
fi

prefix="$1"
current_folder="."

add_prefix_to_symlinks "$prefix" "$current_folder"

echo "Custom prefix added to symlinks in the current folder"

