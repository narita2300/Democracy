#!/bin/bash

# This script updates the path in all .do files within the Dem_Growth_Extend directory.
# It replaces the hardcoded path with the absolute path of the Dem_Growth_Extend directory.

# Get the absolute path to the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEM_GROWTH_EXTEND_DIR="$BASE_DIR/Dem_Growth_Extend"

echo "Updating .do files in: $DEM_GROWTH_EXTEND_DIR"

# Find all .do files in the specified directory and its subdirectories
find "$DEM_GROWTH_EXTEND_DIR" -type f -name "*.do" | while read -r do_file; do
    echo "Processing $do_file..."

    # Create a backup of the original file
    cp "$do_file" "${do_file}.backup"

    # Use sed to replace the hardcoded path.
    # It looks for lines starting with 'global path' or 'global project'
    # and replaces the rest of the line with the new path.
    # The new path is enclosed in quotes for Stata.
    # sed -i '' is used for macOS compatibility.
    sed -i '' -e "s|^global path .*|global path \"$DEM_GROWTH_EXTEND_DIR\"|" \
             -e "s|^global project .*|global project \"$DEM_GROWTH_EXTEND_DIR\"|" "$do_file"

    # Check if sed command was successful
    if [ $? -eq 0 ]; then
        echo "✓ Updated: $do_file"
    else
        echo "✗ Failed to update: $do_file"
        # Restore from backup if sed fails
        mv "${do_file}.backup" "$do_file"
    fi
done

echo ""
echo "Path update complete for .do files in Dem_Growth_Extend."
echo "Backup files have been created with the .backup extension." 