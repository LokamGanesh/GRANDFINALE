@echo off
title Transliterate Bharat - Desktop App Creator
color 0A

echo.
echo  ████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗     ██╗████████╗███████╗██████╗  █████╗ ████████╗███████╗
echo  ╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██║╚══██╔══╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
echo     ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║     ██║   ██║   █████╗  ██████╔╝███████║   ██║   █████╗  
echo     ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║     ██║   ██║   ██╔══╝  ██╔══██╗██╔══██║   ██║   ██╔══╝  
echo     ██║   ██║  ██║██║  ██║██║ ╚████║███████║███████╗██║   ██║   ███████╗██║  ██║██║  ██║   ██║   ███████╗
echo     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
echo.
echo                                    Professional Desktop App Creator
echo                                           भारत - Indian Script Transliteration
echo.
echo ==========================================================================================================
echo.

echo [1/3] Preparing to create professional desktop application...
timeout /t 2 /nobreak >nul

echo [2/3] Generating custom icons and shortcuts...
powershell -ExecutionPolicy Bypass -File "%~dp0create-desktop-app.ps1"

echo.
echo [3/3] Desktop app creation completed successfully!
echo.
echo ✅ Your professional Transliterate Bharat app is ready!
echo 📱 Look for "Transliterate Bharat" icon on your desktop
echo 🚀 Double-click to launch in standalone app mode
echo.
echo Press any key to exit...
pause >nul
