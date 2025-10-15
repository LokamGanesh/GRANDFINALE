@echo off
title Transliterate Bharat - Simple Launcher
color 0B

echo.
echo ████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗     ██╗████████╗███████╗██████╗  █████╗ ████████╗███████╗
echo ╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██║╚══██╔══╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
echo    ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║     ██║   ██║   █████╗  ██████╔╝███████║   ██║   █████╗  
echo    ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║     ██║   ██║   ██╔══╝  ██╔══██╗██╔══██║   ██║   ██╔══╝  
echo    ██║   ██║  ██║██║  ██║██║ ╚████║███████║███████╗██║   ██║   ███████╗██║  ██║██║  ██║   ██║   ███████╗
echo    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
echo.
echo                                      🚀 Starting Your App 🚀
echo                                        भारत - Indian Scripts
echo.
echo ================================================================================================
echo.

echo [1/3] Stopping any existing servers...
taskkill /F /IM node.exe >nul 2>&1

echo [2/3] Starting application servers...
echo ⏳ Please wait while the servers start up...

REM Start the application using regular HTTP (no HTTPS issues)
start /min cmd /c "npm start"

echo [3/3] Waiting for servers to be ready...
:wait_loop
timeout /t 3 /nobreak >nul
netstat -an | findstr ":3000" >nul 2>&1
if %errorlevel% neq 0 (
    echo ⏳ Still starting...
    goto :wait_loop
)

echo ✅ Servers are ready!
echo.
echo 🚀 Opening your app...

REM Find and launch Chrome in app mode
set CHROME_FOUND=0
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app=http://localhost:3000 --new-window
    set CHROME_FOUND=1
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --app=http://localhost:3000 --new-window
    set CHROME_FOUND=1
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    start "" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" --app=http://localhost:3000 --new-window
    set CHROME_FOUND=1
)

REM Fallback to Edge if Chrome not found
if %CHROME_FOUND%==0 (
    if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
        start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app=http://localhost:3000 --new-window
        set CHROME_FOUND=1
    ) else if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
        start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app=http://localhost:3000 --new-window
        set CHROME_FOUND=1
    )
)

REM Final fallback to default browser
if %CHROME_FOUND%==0 (
    start "" "http://localhost:3000"
)

echo.
echo ✅ Transliterate Bharat is now running!
echo 📱 Frontend: http://localhost:3000
echo 🔧 Backend: http://localhost:5000
echo 📱 Mobile: http://192.168.31.73:3000
echo.
echo 💡 The app should open automatically in a dedicated window
echo 💡 Keep this window open to keep the servers running
echo.
echo Press any key to stop the servers and exit...
pause >nul

echo.
echo 🛑 Stopping servers...
taskkill /F /IM node.exe >nul 2>&1
echo ✅ Servers stopped. Goodbye!
timeout /t 2 /nobreak >nul
