#!/bin/bash

# Define directories
DIRS=(models custom_nodes input output user data)

# Create directories if they don't exist
for DIR in "${DIRS[@]}"; do
    if [ ! -d "$DIR" ]; then
        mkdir -p "$DIR"
        echo "Created directory: $DIR"
    fi
done

echo "All necessary directories are set up."
