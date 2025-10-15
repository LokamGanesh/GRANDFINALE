@echo off
title Update App Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   UPDATING APP ICON
echo   Transliterate Bharat
echo ========================================
echo.

echo Regenerating desktop icon with new design...
powershell -ExecutionPolicy Bypass -File "%~dp0create-working-icon.ps1"

echo.
echo ========================================
echo   ICON UPDATED!
echo ========================================
echo.
echo Your desktop icon now has the new design:
echo - Dark rounded square background
echo - Globe wireframe in the center  
echo - Speech bubbles with "A" and "文"
echo - Professional translation app look
echo.
echo The icon matches modern app design standards!
echo.
echo Press any key to exit...
pause >nul
