@echo off
echo Starting Jharkhand Tourism App...
echo.

REM Start server
cd /d "%~dp0\server"
start "Tourism Server" cmd /k "npm start"

REM Wait and start client
timeout /t 3 >nul
cd /d "%~dp0\client"
start "Tourism Client" cmd /k "npm start"

REM Wait and open browser
timeout /t 10 >nul
start http://localhost:3000

echo.
echo App is starting...
echo Frontend: http://localhost:3000
echo Backend: http://localhost:5000
echo.
pause
