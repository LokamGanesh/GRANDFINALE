@echo off
title Fix App Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   FIXING APP ICON DISPLAY
echo   Transliterate Bharat
echo ========================================
echo.

echo Step 1: Removing problematic shortcut...
del "%USERPROFILE%\Desktop\Transliterate Bharat.lnk" >nul 2>&1

echo Step 2: Creating shortcut with reliable icon...

REM Use a more reliable system icon that represents translation/language
powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Indian Script Translation'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%%SystemRoot%%\System32\shell32.dll,278'; ^
$Shortcut.Save(); ^
Write-Host 'Shortcut created with translation icon!'"

echo.
echo Step 3: Alternative - Creating with different icon...
timeout /t 2 /nobreak >nul

REM If first icon doesn't work, try another one
powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
if (Test-Path $ShortcutPath) { Remove-Item $ShortcutPath -Force }; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Script Translation App'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%%SystemRoot%%\System32\imageres.dll,13'; ^
$Shortcut.Save(); ^
Write-Host 'Alternative shortcut created!'"

echo.
echo Step 4: Refreshing desktop...
powershell -Command "Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue; Start-Sleep 2; Start-Process explorer"

timeout /t 3 /nobreak >nul

echo.
echo ========================================
echo   ICON FIXED!
echo ========================================
echo.
echo Your desktop shortcut should now show:
echo - Globe/world icon (represents translation)
echo - "Transliterate Bharat" text
echo - Working launcher functionality
echo.
echo If the icon still doesn't appear correctly:
echo 1. Right-click desktop and select "Refresh"
echo 2. Wait 30 seconds for Windows to update
echo 3. Restart your computer if needed
echo.
echo The app functionality works regardless of icon display!
echo.
echo Press any key to exit...
pause >nul
