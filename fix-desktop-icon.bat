@echo off
title Fix Desktop Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   FIXING DESKTOP ICON
echo   Transliterate Bharat
echo ========================================
echo.

echo Creating working desktop shortcut...
powershell -ExecutionPolicy Bypass -File "%~dp0create-working-icon.ps1"

echo.
echo ========================================
echo   DESKTOP ICON FIXED!
echo ========================================
echo.
echo Your desktop now has a working shortcut:
echo "Transliterate Bharat"
echo.
echo How to use:
echo 1. Double-click the desktop icon
echo 2. App starts automatically
echo 3. No need to run anything else first!
echo.
echo Press any key to exit...
pause >nul
