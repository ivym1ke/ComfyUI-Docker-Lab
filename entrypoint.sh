#!/bin/bash

# Define directories to replace
MOUNT_DIRS=(
    "models"
    "custom_nodes"
    "input"
    "output"
    "user"
)

# Backup location for default models
SOURCE_MODELS="/default_models_backup"
TARGET_MODELS="/ComfyUI/models"

echo "Setting up ComfyUI directories..."

# Loop through directories, remove them from /ComfyUI, and symlink the bind mount
for DIR in "${MOUNT_DIRS[@]}"; do
    TARGET="/ComfyUI/$DIR"
    SOURCE="/$DIR"

    echo "Removing $TARGET and symlinking $SOURCE -> $TARGET"
    rm -rf "$TARGET"
    ln -s "$SOURCE" "$TARGET"
done

# Restore models directory if it's empty
if [ -z "$(ls -A $TARGET_MODELS 2>/dev/null)" ]; then
    echo "Mounted models directory is empty. Restoring default structure..."
    cp -r $SOURCE_MODELS/* $TARGET_MODELS/
fi

LORA_TRAINER_DIR="/ComfyUI/custom_nodes/Lora-Training-in-Comfy"
REPO_URL="https://github.com/LarryJane491/Lora-Training-in-Comfy"

if [ ! -d "$LORA_TRAINER_DIR/.git" ]; then
    echo "Cloning Lora Trainer into custom_nodes..."
    git clone --depth 1 "$REPO_URL" "$LORA_TRAINER_DIR"
    cd $LORA_TRAINER_DIR && . /comfy_env/bin/activate && pip install --constraint /constraints.txt -r requirements.txt
else
    echo "Lora Trainer already exists. Skipping clone."
fi

# # Install ComfyUI-Manager if missing
# MANAGER_DIR="/ComfyUI/custom_nodes/comfyui-manager"
# REPO_URL="https://github.com/ltdrdata/ComfyUI-Manager"

# if [ ! -d "$MANAGER_DIR/.git" ]; then
#     echo "Cloning ComfyUI-Manager into custom_nodes..."
#     git clone --depth 1 "$REPO_URL" "$MANAGER_DIR"
# else
#     echo "ComfyUI-Manager already exists. Skipping clone."
# fi

echo "Starting ComfyUI..."
cd /ComfyUI
exec "$@"
