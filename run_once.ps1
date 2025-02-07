$dirs = @("models", "custom_nodes", "input", "output", "user", "data")

foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
        Write-Output "Created directory: $dir"
    }
}

Write-Output "All necessary directories are set up."
