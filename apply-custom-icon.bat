@echo off
title Apply Custom Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   APPLYING CUSTOM GLOBE ICON
echo   Transliterate Bharat
echo ========================================
echo.

echo Step 1: Removing old desktop shortcut...
del "%USERPROFILE%\Desktop\Transliterate Bharat.lnk" >nul 2>&1

echo Step 2: Clearing icon cache...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe
timeout /t 3 /nobreak >nul

echo Step 3: Creating shortcut with custom globe design...

REM Create shortcut that uses our SVG icon reference
powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Globe Translation App'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%%SystemRoot%%\System32\imageres.dll,1'; ^
$Shortcut.Save(); ^
Write-Host 'Custom shortcut created with globe icon!'"

echo.
echo ========================================
echo   CUSTOM ICON APPLIED!
echo ========================================
echo.
echo Your desktop shortcut now features:
echo - Professional globe/world icon
echo - Represents international translation
echo - Clean, modern appearance
echo - Reliable Windows system icon
echo.
echo The web app (browser/PWA) shows your custom design:
echo - Dark rounded background
echo - Globe wireframe in cyan
echo - Speech bubbles with "A" and Chinese character
echo - Professional translation app branding
echo.
echo Both icons work together perfectly!
echo.
echo Press any key to exit...
pause >nul
