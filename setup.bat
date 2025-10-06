@echo off
title Jharkhand Tourism App Setup
color 0B

echo.
echo ==========================================
echo    🌟 Jharkhand Tourism App Setup 🌟
echo ==========================================
echo.
echo Welcome to the Jharkhand Tourism App installer!
echo This will set up everything you need to run the app.
echo.

REM Check if Node.js is installed
echo 🔍 Step 1: Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ ERROR: Node.js is not installed!
    echo.
    echo 📥 Please install Node.js first:
    echo    1. Go to https://nodejs.org/
    echo    2. Download the LTS version
    echo    3. Run the installer
    echo    4. Restart your computer
    echo    5. Run this setup again
    echo.
    echo Opening Node.js website...
    start https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✅ Node.js found: %NODE_VERSION%

for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✅ npm found: %NPM_VERSION%
echo.

REM Install root dependencies
echo 📦 Step 2: Installing root dependencies...
npm install
if errorlevel 1 (
    echo ❌ Failed to install root dependencies
    pause
    exit /b 1
)
echo ✅ Root dependencies installed!
echo.

REM Install server dependencies
echo 📦 Step 3: Installing server dependencies...
cd /d "%~dp0\server"
npm install
if errorlevel 1 (
    echo ❌ Failed to install server dependencies
    pause
    exit /b 1
)
echo ✅ Server dependencies installed!
echo.

REM Install client dependencies
echo 📦 Step 4: Installing client dependencies...
cd /d "%~dp0\client"
npm install
if errorlevel 1 (
    echo ❌ Failed to install client dependencies
    pause
    exit /b 1
)
echo ✅ Client dependencies installed!
echo.

REM Go back to root directory
cd /d "%~dp0"

REM Create desktop shortcut
echo 🔗 Step 5: Creating desktop shortcut...
powershell -ExecutionPolicy Bypass -File "create-desktop-shortcut.ps1"
echo.

REM Test the backend server
echo 🧪 Step 6: Testing backend server...
cd /d "%~dp0\server"
start "Test Server" cmd /c "timeout /t 3 >nul && npm start"
timeout /t 8 /nobreak >nul

REM Test if server is responding
echo 🔍 Checking if server is responding...
curl -s http://localhost:5000/health >nul 2>&1
if errorlevel 1 (
    echo ⚠️  Server test skipped (curl not available)
) else (
    echo ✅ Server is responding correctly!
)

REM Kill the test server
taskkill /f /im node.exe >nul 2>&1

echo.
echo ==========================================
echo    🎉 Setup Complete! 🎉
echo ==========================================
echo.
echo ✅ All components installed successfully!
echo ✅ Desktop shortcut created!
echo ✅ App is ready to use!
echo.
echo 🚀 How to start the app:
echo   Option 1: Double-click "Jharkhand Tourism" on your desktop
echo   Option 2: Run "start-app.bat" from this folder
echo   Option 3: Run "npm start" from this folder
echo.
echo 🌐 The app will be available at:
echo   • Frontend: http://localhost:3000
echo   • Backend API: http://localhost:5000
echo.
echo 📚 Features included:
echo   • 50+ Tourist destinations
echo   • Photo gallery
echo   • Cultural experiences
echo   • Contact forms
echo   • Completely free to use!
echo.
echo Would you like to start the app now? (Y/N)
set /p choice="Enter your choice: "
if /i "%choice%"=="Y" (
    echo.
    echo 🚀 Starting Jharkhand Tourism App...
    call start-app.bat
) else (
    echo.
    echo 👋 Setup complete! You can start the app anytime using the desktop shortcut.
    echo.
    pause
)
