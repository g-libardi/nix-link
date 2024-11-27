#!/bin/bash

# Function to compute the difference between two lists
compute_difference() {
  local input="$*"

  # Validate input format
  if [[ ! "$input" =~ --- ]]; then
    echo "Error: Input must contain two lists separated by '---'."
    echo "Example: 'item1 item2 --- item3 item4'"
    exit 1
  fi

  # Split input into two lists
  local list1="${input%%---*}"
  local list2="${input##*---}"

  # Remove trailing/leading spaces from lists
  list1=$(echo "$list1" | xargs)
  list2=$(echo "$list2" | xargs)

  # Convert the lists into arrays
  IFS=' ' read -r -a arr1 <<< "$list1"
  IFS=' ' read -r -a arr2 <<< "$list2"

  # Compute items in list1 but not in list2
  echo "Items in list1 but not in list2:"
  for item in "${arr1[@]}"; do
    if ! [[ " ${arr2[*]} " =~ " $item " ]]; then
      echo "$item"
    fi
  done

  # Compute items in list2 but not in list1
  echo "Items in list2 but not in list1:"
  for item in "${arr2[@]}"; do
    if ! [[ " ${arr1[*]} " =~ " $item " ]]; then
      echo "$item"
    fi
  done
}


diff=$(compute_difference $@)
echo "Collecting garbage: $diff\n\n"

for item in $diff; do
  IFS=':' read -r source_path target_path <<< "$item"
  if [ -e "$target_path" ]; then
    rm -rf "$target_path"
    echo "Removed symlink: $target_path -> $source_path"
  else
    echo "Symlink already removed: $target_path -> $source_path"
  fi
done

echo "Garbage collection completed.\n\n"
