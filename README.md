# ComfyUI-Docker-Lab
Personal ComfyUI Docker lab - tested w/ Nvidia 2070 SUPER

## Overview
This project sets up a **ComfyUI AI Lab** in a Docker container with persistent storage for models, input/output files, and configurations.

## Setup Instructions

### 1. Prepare the Directories
Run the appropriate script for your OS to create necessary directories:

- **Windows (Batch script):**
  ```cmd
  run_once.bat
  ```
- **Linux/macOS (Shell script):**
  ```sh
  bash run_once.sh
  ```
- **Windows (PowerShell script):**
  ```powershell
  powershell -ExecutionPolicy Bypass -File run_once.ps1
  ```

### 2. Build and Run the Container
After preparing the directories, start the container:

```sh
docker-compose up -d
```

### 3. Access the Interface
- Open a browser and go to:  
  **http://localhost:8188**

### 4. Persistent Directories
The following directories are mapped to the container for data persistence:

| Directory      | Purpose |
|---------------|---------|
| `models/`     | Stores AI models |
| `custom_nodes/` | Stores custom AI processing nodes |
| `input/`      | Folder for input files |
| `output/`     | Folder for processed output files |
| `user/`       | User-specific configurations |
| `data/`       | Testing training data  |

### 5. Stopping & Restarting
- **Stop the container:**  
  ```sh
  docker-compose down
  ```
- **Restart the container:**  
  ```sh
  docker-compose up -d
  ```

### 6. Logs & Debugging
- **View logs:**  
  ```sh
  docker logs -f ailab
  ```
- **Enter the container shell:**  
  ```sh
  docker exec -it ailab /bin/bash
  ```

## Troubleshooting
### Resetting the Virtual Environment

If you need to delete and recreate the Python virtual environment inside the Docker volume, follow these steps:

1. **Stop the container:**
   ```sh
   docker-compose down
   ```

2. **Remove the existing virtual environment volume:**
   ```sh
   docker volume rm comfy_venv
   ```

3. **Rebuild and restart the container to recreate the virtual environment:**
   ```sh
   docker-compose up --build -d
   ```

This will force Docker to reinstall dependencies inside a fresh virtual environment.

## Contributing
Feel free to submit issues or pull requests to improve the setup.

## License

![license](https://c.tenor.com/7A9DklngAakAAAAC/tenor.gif)