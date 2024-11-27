#!/bin/bash

source ./utils.sh


# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 'source_path:target_path source_path:target_path ...'"
  exit 1
fi


# Get the lists of items
old_links=$(read_lock_file)
new_links=$@


# run the garbage collector
