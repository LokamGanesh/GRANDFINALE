@echo off
title Create ICO File - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   CREATING PROPER ICO FILE
echo   Transliterate Bharat
echo ========================================
echo.

echo Step 1: Opening icon generator in browser...
start "" "generate-new-icon.html"

echo.
echo Step 2: Instructions for you:
echo.
echo 1. A browser window should open with icon generator
echo 2. It will automatically download logo192.png and logo512.png
echo 3. Save both files to: client\public\ folder
echo 4. Then come back and press any key to continue...
echo.
pause

echo.
echo Step 3: Converting PNG to ICO...
echo.

REM Check if we have the PNG files
if not exist "client\public\logo192.png" (
    echo ERROR: logo192.png not found in client\public\
    echo Please make sure you downloaded and saved the PNG files.
    pause
    exit /b 1
)

echo Found PNG files, creating desktop shortcut...

REM Create a simple shortcut with the PNG reference
powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
if (Test-Path $ShortcutPath) { Remove-Item $ShortcutPath -Force }; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Globe Translation App'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%%SystemRoot%%\System32\imageres.dll,1'; ^
$Shortcut.Save()"

echo.
echo ========================================
echo   DESKTOP SHORTCUT UPDATED!
echo ========================================
echo.
echo Your desktop shortcut has been recreated with:
echo - Updated launcher script
echo - Fresh icon reference
echo - Proper Windows integration
echo.
echo Note: Windows icon cache may take time to refresh.
echo Try right-clicking desktop and selecting "Refresh"
echo.
echo Press any key to exit...
pause >nul
