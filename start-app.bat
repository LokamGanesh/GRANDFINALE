@echo off
title Transliterate Bharat App Launcher
color 0A

echo.
echo ========================================
echo    🌟 Transliterate Bharat App Launcher 🌟
echo ========================================
echo.
echo 🚀 Starting Transliterate Bharat application...
echo.

REM Check if Node.js is installed
echo 🔍 Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ ERROR: Node.js is not installed or not in PATH
    echo.
    echo 📥 Please install Node.js from https://nodejs.org/
    echo    - Download the LTS version
    echo    - Run the installer
    echo    - Restart your computer
    echo    - Try running this app again
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✅ Node.js found: %NODE_VERSION%

REM Check if npm is available
echo 🔍 Checking npm installation...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: npm is not available
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✅ npm found: %NPM_VERSION%
echo.

REM Check if dependencies are installed
echo 🔍 Checking server dependencies...
if not exist "%~dp0\server\node_modules" (
    echo 📦 Installing server dependencies...
    cd /d "%~dp0\server"
    npm install
    if errorlevel 1 (
        echo ❌ Failed to install server dependencies
        pause
        exit /b 1
    )
)

echo 🔍 Checking client dependencies...
if not exist "%~dp0\client\node_modules" (
    echo 📦 Installing client dependencies...
    cd /d "%~dp0\client"
    npm install
    if errorlevel 1 (
        echo ❌ Failed to install client dependencies
        pause
        exit /b 1
    )
)

echo ✅ All dependencies are ready!
echo.

REM Start the backend server
echo 🔧 Starting backend server...
cd /d "%~dp0\server"
start "Transliterate Server" cmd /c "title Transliterate Server && echo 🔧 Starting Transliterate Server... && npm start"

REM Wait a moment for server to start
echo ⏳ Waiting for server to initialize...
timeout /t 5 /nobreak >nul

REM Start the frontend client
echo 🎨 Starting frontend client...
cd /d "%~dp0\client"
start "Transliterate Client" cmd /c "title Transliterate Client && echo 🎨 Starting Transliterate Client... && npm start"

echo.
echo ========================================
echo  🌟 Transliterate Bharat App is starting...
echo  
echo  🔧 Backend Server: http://localhost:5000
echo  🎨 Frontend App: http://localhost:3000
echo  
echo  🌐 The app will open in your browser shortly.
echo ========================================
echo.

REM Wait for frontend to start and open browser
echo ⏳ Waiting for frontend to start...
timeout /t 15 /nobreak >nul

echo 🌐 Opening browser...
start http://localhost:3000

echo.
echo ✅ App launched successfully!
echo.
echo 📝 Instructions:
echo   • The app is now running in your browser
echo   • Keep both server windows open while using the app
echo   • Close the server windows when you're done
echo.
echo 🔗 Useful URLs:
echo   • Main App: http://localhost:3000
echo   • API Server: http://localhost:5000
echo   • API Health: http://localhost:5000/health
echo.
echo Press any key to close this launcher...
pause >nul
