@echo off
echo Generating professional app icons...
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed or not in PATH
    echo Please install Python from https://python.org
    pause
    exit /b 1
)

REM Install required packages
echo Installing required packages...
pip install Pillow cairosvg >nul 2>&1

REM Generate icons
echo Generating icons from SVG...
python generate-ico.py

echo.
echo Icon generation completed!
pause
