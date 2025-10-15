@echo off
echo ========================================
echo    Getting IP Address for Phone Access
echo ========================================
echo.

echo Your computer's IP addresses:
echo.

:: Get all IP addresses
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    echo IP Address: %%a
)

echo.
echo ========================================
echo    Phone Access Instructions
echo ========================================
echo.
echo 1. Make sure your phone and computer are on the same WiFi network
echo 2. Start your Sign Board Scanner app:
echo    - Server: cd server ^&^& npm start
echo    - Client: cd client ^&^& npm start
echo.
echo 3. On your phone, open browser and go to:
echo    http://[IP_ADDRESS]:3000
echo.
echo Example: If your IP is 192.168.1.100, use:
echo    http://192.168.1.100:3000
echo.
echo Note: The client dev server needs to be configured to accept
echo external connections. See the setup instructions below.
echo.
pause

echo.
echo ========================================
echo    Setting up for Phone Access
echo ========================================
echo.
echo To allow phone access, you need to modify the client start script.
echo This will be done automatically...
echo.

:: Check if client package.json exists
if exist "client\package.json" (
    echo Updating client configuration for external access...
    
    :: Create backup
    copy "client\package.json" "client\package.json.backup" >nul
    
    :: Update the start script to allow external access
    powershell -Command "(Get-Content 'client\package.json') -replace '\"start\":\s*\"react-scripts start\"', '\"start\": \"react-scripts start --host 0.0.0.0\"' | Set-Content 'client\package.json'"
    
    echo ✓ Client configured for external access
    echo.
    echo Now you can access the app from your phone using:
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address" ^| findstr /v "127.0.0.1"') do (
        echo http://%%a:3000
    )
) else (
    echo Error: client\package.json not found!
    echo Please run this script from the transliterateAPP root directory.
)

echo.
echo ========================================
echo    Quick Start Commands
echo ========================================
echo.
echo Run these commands in separate terminals:
echo.
echo Terminal 1 (Server):
echo cd server
echo npm start
echo.
echo Terminal 2 (Client):
echo cd client  
echo npm start
echo.
echo The app will be accessible on your phone once both are running!
echo.
pause
