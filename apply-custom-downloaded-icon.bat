@echo off
title Apply Custom Downloaded Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   APPLYING CUSTOM DOWNLOADED ICON
echo   Transliterate Bharat
echo ========================================
echo.

echo Step 1: Checking for downloaded PNG files...

if not exist "client\public\logo192.png" (
    echo ERROR: logo192.png not found in client\public\
    echo.
    echo Please make sure you:
    echo 1. Opened create-custom-icon-from-image.html
    echo 2. Downloaded the PNG files
    echo 3. Saved them to client\public\ folder
    echo.
    echo Then run this script again.
    pause
    exit /b 1
)

echo ✅ Found PNG files!

echo Step 2: Creating ICO file from PNG...

powershell -ExecutionPolicy Bypass -Command ^
"Add-Type -AssemblyName System.Drawing; ^
$png = [System.Drawing.Image]::FromFile('client\public\logo192.png'); ^
$bitmap = New-Object System.Drawing.Bitmap($png, 256, 256); ^
$icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon()); ^
$fileStream = [System.IO.FileStream]::new('transliterate-custom-new.ico', [System.IO.FileMode]::Create); ^
$icon.Save($fileStream); ^
$fileStream.Close(); ^
$png.Dispose(); ^
$bitmap.Dispose(); ^
$icon.Dispose(); ^
Write-Host 'ICO file created successfully!'"

echo Step 3: Removing old desktop shortcut...
del "%USERPROFILE%\Desktop\Transliterate Bharat.lnk" >nul 2>&1

echo Step 4: Clearing icon cache...
del "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe
timeout /t 3 /nobreak >nul

echo Step 5: Creating new shortcut with custom icon...

powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Custom Translation Icon'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%~dp0transliterate-custom-new.ico,0'; ^
$Shortcut.Save(); ^
Write-Host 'Custom icon shortcut created!'"

echo.
echo ========================================
echo   CUSTOM ICON APPLIED!
echo ========================================
echo.
echo Your desktop shortcut now features:
echo - Custom translation icon design
echo - Professional gradient background
echo - Translation arrows and symbols
echo - Language characters (A and अ)
echo.
echo The icon should appear within 30 seconds!
echo.
echo If the icon doesn't show immediately:
echo 1. Right-click desktop and select "Refresh"
echo 2. Wait 1 minute for Windows to update cache
echo 3. Restart computer if needed
echo.
echo Your app functionality works perfectly regardless!
echo.
echo Press any key to exit...
pause >nul
