#!/bin/bash

# Define the source (backup location) and target (bind mount location)
SOURCE_MODELS="/default_models_backup"
TARGET_MODELS="/ComfyUI/models"

# If the mounted models directory is empty, restore from backup
if [ -z "$(ls -A $TARGET_MODELS 2>/dev/null)" ]; then
    echo "Mounted models directory is empty. Restoring default structure..."
    cp -r $SOURCE_MODELS/* $TARGET_MODELS/
fi

# Install ComfyUI-Manager
MANAGER_DIR="/ComfyUI/custom_nodes/comfyui-manager"
REPO_URL="https://github.com/ltdrdata/ComfyUI-Manager"

# Clone ComfyUI-Manager only if it doesn't already exist
if [ ! -d "$MANAGER_DIR/.git" ]; then
    echo "Cloning ComfyUI-Manager into custom_nodes..."
    git clone --depth 1 "$REPO_URL" "$MANAGER_DIR"
else
    echo "ComfyUI-Manager already exists. Skipping clone."
fi

# Start ComfyUI
exec "$@"
