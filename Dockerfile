# Use a specific Ubuntu LTS version instead of 'latest' to avoid surprises
FROM ubuntu:22.04

# Set environment variables for non-interactive apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists and install common development tools
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    build-essential \
    git \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-venv \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add NVIDIA's official package repository for CUDA and container toolkit
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
    apt-get update && \
    apt-get install -y nvidia-container-toolkit && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /ComfyUI

# Create and activate a Python virtual environment (Persistent via Docker volume)
RUN python3 -m venv /comfy_env && \
    . /comfy_env/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir xformers --index-url https://download.pytorch.org/whl/cu118 && \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 && \
    pip install GitPython PyGithub matrix-client==0.4.0 transformers "huggingface-hub>0.20" typer rich typing-extensions toml uv && \
    pip install -r requirements.txt

# Ensure the virtual environment is activated on startup
ENV PATH="/comfy_env/bin:$PATH"

# Default command
CMD ["/comfy_env/bin/python", "main.py", "--listen", "0.0.0.0", "--port", "8188"]
