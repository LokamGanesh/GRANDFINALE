@echo off
echo ========================================
echo   Transliterate Bharat App Launcher
echo ========================================
echo.

REM Kill any existing processes
taskkill /f /im node.exe >nul 2>&1

REM Wait a moment
timeout /t 2 >nul

echo Starting backend server...
cd /d "%~dp0\server"
start "Transliterate Server" cmd /k "npm start"

REM Wait for server to start
timeout /t 5 >nul

echo Starting frontend client...
cd /d "%~dp0\client"
start "Transliterate Client" cmd /k "npm start"

REM Wait for client to start
timeout /t 10 >nul

echo Opening browser...
start http://localhost:3000

echo.
echo App is starting!
echo Frontend: http://localhost:3000
echo Backend: http://localhost:5000
echo.
echo Keep the server windows open while using the app.
pause
