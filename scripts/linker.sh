#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 'source_path:target_path source_path:target_path ...'"
  exit 1
fi

# Get the list of items
items=$1

# Check if any target_path already exists
for item in $items; do
  # Split the item into source_path and target_path
  IFS=':' read -r source_path target_path <<< "$item"

  # Validate input format
  if [ -z "$source_path" ] || [ -z "$target_path" ]; then
    echo "Invalid entry: $item. Both source_path and target_path must be specified."
    exit 1
  fi

  # Check if the target_path exists
  if [ -e "$target_path" ]; then
    echo "Error: Target path already exists: $target_path"
    echo "Operation aborted."
    exit 1
  fi
done

# Create symlinks if all target paths are clear
for item in $items; do
  # Split the item into source_path and target_path
  IFS=':' read -r source_path target_path <<< "$item"

  # Create the symbolic link
  ln -sf "$source_path" "$target_path"

  if [ $? -eq 0 ]; then
    echo "Created symlink: $target_path -> $source_path"
  else
    echo "Failed to create symlink for: $item"
  fi
done

