@echo off
title Transliterate Bharat - Desktop App Launcher
color 0B

echo.
echo ████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗     ██╗████████╗███████╗██████╗  █████╗ ████████╗███████╗
echo ╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██║╚══██╔══╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
echo    ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║     ██║   ██║   █████╗  ██████╔╝███████║   ██║   █████╗  
echo    ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║     ██║   ██║   ██╔══╝  ██╔══██╗██╔══██║   ██║   ██╔══╝  
echo    ██║   ██║  ██║██║  ██║██║ ╚████║███████║███████╗██║   ██║   ███████╗██║  ██║██║  ██║   ██║   ███████╗
echo    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚�═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
echo.
echo                                      🚀 Desktop App Launcher 🚀
echo                                        भारत - Indian Scripts
echo.
echo ================================================================================================
echo.

REM Check if server is already running
echo [1/3] Checking server status...
netstat -an | findstr ":3000" >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Server is already running
    goto :launch_app
)

echo [2/3] Starting HTTPS server...
echo ⏳ Please wait while the server starts up...
start /min cmd /c "npm run start:https"

REM Wait for server to start
echo ⏳ Waiting for server to be ready...
:wait_loop
timeout /t 2 /nobreak >nul
netstat -an | findstr ":3000" >nul 2>&1
if %errorlevel% neq 0 goto :wait_loop

echo ✅ Server is ready!

:launch_app
echo [3/3] Launching desktop app...

REM Find Chrome
set CHROME_PATH=""
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
)

REM Launch app
if not %CHROME_PATH%=="" (
    echo 🚀 Launching in Chrome app mode...
    start "" %CHROME_PATH% --app=https://localhost:3000 --new-window --disable-web-security --no-first-run
) else (
    echo 🚀 Launching in default browser...
    start "" "https://localhost:3000"
)

echo.
echo ✅ Transliterate Bharat is now running!
echo 📱 The app should open in a dedicated window
echo 🔒 Accept any security warnings (this is normal for localhost HTTPS)
echo.
echo Press any key to exit this launcher...
pause >nul
