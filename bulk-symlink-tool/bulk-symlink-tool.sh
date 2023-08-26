#!/bin/bash

# Function to add custom content before symlink addresses
add_prefix_to_symlinks() {
    local prefix="$1"
    local folder="$2"

    find "$folder" -type l -exec sh -c '
        for symlink do
            target=$(readlink "$symlink")
            new_target="$prefix$target"
            ln -sf "$new_target" "$symlink"
        done
    ' sh {} +
}

# Main script
if [ $# -lt 2 ]; then
    echo "Usage: $0 <prefix> <folder>"
    exit 1
fi

prefix="$1"
folder="$2"

if [ ! -d "$folder" ]; then
    echo "Error: The specified folder does not exist."
    exit 1
fi

add_prefix_to_symlinks "$prefix" "$folder"

echo "Custom prefix added to symlinks in $folder"

