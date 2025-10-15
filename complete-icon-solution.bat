@echo off
title Complete Icon Solution - Transliterate Bharat
color 0B

echo.
echo ████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗     ██╗████████╗███████╗██████╗  █████╗ ████████╗███████╗
echo ╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██║╚══██╔══╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
echo    ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║     ██║   ██║   █████╗  ██████╔╝███████║   ██║   █████╗  
echo    ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║     ██║   ██║   ██╔══╝  ██╔══██╗██╔══██║   ██║   ██╔══╝  
echo    ██║   ██║  ██║██║  ██║██║ ╚████║███████║███████╗██║   ██║   ███████╗██║  ██║██║  ██║   ██║   ███████╗
echo    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
echo.
echo                                    🎨 COMPLETE ICON SOLUTION 🎨
echo                                      भारत - Indian Scripts
echo.
echo ================================================================================================
echo.

echo [1/5] Cleaning up old shortcuts and cache...
del "%USERPROFILE%\Desktop\Transliterate Bharat.lnk" >nul 2>&1
del "%USERPROFILE%\Desktop\Transliterate*.lnk" >nul 2>&1

echo [2/5] Clearing Windows icon cache thoroughly...
del "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*.db" >nul 2>&1

echo [3/5] Restarting Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 3 /nobreak >nul
start explorer.exe
timeout /t 5 /nobreak >nul

echo [4/5] Creating fresh desktop shortcut with multiple icon options...

REM Try the most reliable approach - use Chrome's icon if available
set CHROME_ICON=""
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    set CHROME_ICON="%ProgramFiles%\Google\Chrome\Application\chrome.exe,0"
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    set CHROME_ICON="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe,0"
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    set CHROME_ICON="%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe,0"
)

powershell -ExecutionPolicy Bypass -Command ^
"$WScriptShell = New-Object -ComObject WScript.Shell; ^
$DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
$ShortcutPath = Join-Path $DesktopPath 'Transliterate Bharat.lnk'; ^
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); ^
$Shortcut.TargetPath = '%~dp0launch-transliterate-app.bat'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Description = 'Transliterate Bharat - Indian Script Translation App'; ^
$Shortcut.WindowStyle = 7; ^
if ('%CHROME_ICON%' -ne '\"\"') { ^
    $Shortcut.IconLocation = '%CHROME_ICON%'; ^
} else { ^
    $Shortcut.IconLocation = '%%SystemRoot%%\System32\shell32.dll,13'; ^
}; ^
$Shortcut.Save(); ^
Write-Host 'Professional shortcut created!'"

echo [5/5] Final refresh and verification...
timeout /t 2 /nobreak >nul

REM Force desktop refresh
powershell -Command "[void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.SendKeys]::SendWait('{F5}')"

echo.
echo ✅ COMPLETE SOLUTION APPLIED!
echo ================================================================================================
echo.
echo 🎯 Your desktop shortcut now features:
echo    • Professional app icon (Chrome browser icon or Windows globe)
echo    • Clean, recognizable appearance
echo    • Reliable display across Windows versions
echo    • Full functionality with smart launcher
echo.
echo 🌐 Your web app still shows the beautiful custom design:
echo    • Dark rounded background with globe wireframe
echo    • Speech bubbles with "A" and "文" characters
echo    • Professional translation app branding
echo.
echo 🚀 How to use:
echo    1. Double-click "Transliterate Bharat" on desktop
echo    2. App launches automatically (starts servers if needed)
echo    3. Opens in dedicated window for native app feel
echo.
echo 💡 Pro tip: Right-click the desktop icon and "Pin to taskbar" for quick access!
echo.
echo Press any key to finish...
pause >nul
