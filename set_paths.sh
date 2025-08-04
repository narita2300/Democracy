#!/bin/bash

# Democracy Project Path Configuration Script
# This script sets the main path for all configuration files in the project

# Get the current directory (should be the Democracy folder)
DEMOCRACY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Extract the parent directory (this should be the main_path)
MAIN_PATH="$(dirname "$DEMOCRACY_DIR")"

echo "Setting up paths for Democracy project..."
echo "Democracy folder: $DEMOCRACY_DIR"
echo "Main path will be set to: $MAIN_PATH"

# Function to update a file with the new path
update_file() {
    local file_path="$1"
    local sed_script="$2"
    
    if [ -f "$file_path" ]; then
        # Create backup
        cp "$file_path" "${file_path}.backup"
        
        # Update the file
        # The '-i' option for sed on macOS requires an extension for backup.
        # We provide a space and then the extension '.tmp'.
        sed -i '' "$sed_script" "$file_path"
        echo "✓ Updated: $file_path"
    else
        echo "✗ File not found: $file_path"
    fi
}

# Update PythonPrep/paths.py
echo ""
echo "Updating Python configuration..."
update_file "$DEMOCRACY_DIR/Democracy_Main/PythonPrep/paths.py" \
    "s|^main_path = .*|main_path = \"$MAIN_PATH\"|"

# Update MainAnalysis/paths.R
echo ""
echo "Updating R configuration..."
update_file "$DEMOCRACY_DIR/Democracy_Main/MainAnalysis/paths.R" \
    "s|^main_path <- .*|main_path <- \"$MAIN_PATH\"|"

# Update MainAnalysis/code/run_all.do
echo ""
echo "Updating Stata configuration..."
update_file "$DEMOCRACY_DIR/Democracy_Main/MainAnalysis/code/run_all.do" \
    "s|^global main_path .*|global main_path \"$MAIN_PATH\"|"

echo ""
echo "Path configuration complete!"
echo ""
echo "All configuration files have been updated to use:"
echo "Main path: $MAIN_PATH"
echo ""
echo "Backup files have been created with .backup extension"
echo "You can now run your Python notebooks, R scripts, and Stata do-files"
echo ""
echo "Usage examples:"
echo "  ./set_paths.sh                           # Auto-detect path"
echo "  ./set_paths.sh /custom/path             # Use custom path" 