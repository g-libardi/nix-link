
LOCK_FILE_PATH="links.lock"


read_lock_file() {
  if [ -f "$LOCK_FILE_PATH" ]; then
    while IFS= read -r line; do
      echo "$line"
    done < "$LOCK_FILE_PATH"
  fi
}


write_lock_file() {
  if [ -z "$1" ]; then
    echo "Error: No argument provided."
    exit 1
  fi
  echo "$1" >> "$LOCK_FILE_PATH"
}


