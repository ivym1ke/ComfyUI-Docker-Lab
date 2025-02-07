@echo off
setlocal

:: Define directories
set DIRS=models custom_nodes input output user data

:: Create directories if they don't exist
for %%D in (%DIRS%) do (
    if not exist "%%D" (
        mkdir "%%D"
        echo Created directory: %%D
    )
)

echo All necessary directories are set up.
endlocal
