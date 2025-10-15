@echo off
title Fix Desktop Icon - Transliterate Bharat
color 0A

echo.
echo ========================================
echo   FIXING DESKTOP ICON RIGHT NOW
echo   Transliterate Bharat
echo ========================================
echo.

echo Removing old shortcut...
del "%USERPROFILE%\Desktop\Transliterate Bharat.lnk" >nul 2>&1

echo Creating new shortcut with globe icon...

REM Create shortcut with a globe/world icon from Windows
powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Indian Script Translation App'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.IconLocation = '%%SystemRoot%%\System32\imageres.dll,13'; ^
$Shortcut.Save(); ^
Write-Host 'Desktop shortcut created with globe icon!'"

echo.
echo Refreshing desktop...
powershell -Command "Stop-Process -Name explorer -Force; Start-Sleep 2; Start-Process explorer"

timeout /t 3 /nobreak >nul

echo.
echo ========================================
echo   ICON FIXED!
echo ========================================
echo.
echo Your desktop now has "Transliterate Bharat" with:
echo - Globe/world icon (represents translation)
echo - Working launcher that starts servers
echo - Professional appearance
echo.
echo The icon should be updated now!
echo If not, try right-clicking desktop and "Refresh"
echo.
echo Press any key to exit...
pause >nul
