@echo off
echo ========================================
echo    Sign Board Scanner - Phone Access Setup
echo ========================================
echo.

:: Get the computer's IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address" ^| findstr /v "127.0.0.1" ^| findstr /v "169.254"') do (
    set "COMPUTER_IP=%%a"
    set "COMPUTER_IP=!COMPUTER_IP: =!"
)

if "%COMPUTER_IP%"=="" (
    echo Error: Could not detect your computer's IP address.
    echo Please make sure you're connected to WiFi.
    pause
    exit /b 1
)

echo Your computer's IP address: %COMPUTER_IP%
echo.

:: Configure client for external access
echo [1/3] Configuring client for phone access...
if exist "client\package.json" (
    :: Create backup
    if not exist "client\package.json.backup" (
        copy "client\package.json" "client\package.json.backup" >nul
    )
    
    :: Update start script for external access
    powershell -Command "(Get-Content 'client\package.json') -replace '\"start\":\s*\"react-scripts start.*?\"', '\"start\": \"set HOST=0.0.0.0 && react-scripts start\"' | Set-Content 'client\package.json'"
    echo ✓ Client configured for external access
) else (
    echo Error: client\package.json not found!
    pause
    exit /b 1
)

:: Configure server for external access
echo [2/3] Configuring server for phone access...
if exist "server\server.js" (
    :: Check if server is already configured for external access
    findstr /c:"0.0.0.0" "server\server.js" >nul
    if errorlevel 1 (
        echo Updating server configuration...
        :: Create backup
        if not exist "server\server.js.backup" (
            copy "server\server.js" "server\server.js.backup" >nul
        )
        
        :: Update server to listen on all interfaces
        powershell -Command "(Get-Content 'server\server.js') -replace 'app\.listen\(PORT.*?\)', 'app.listen(PORT, \"0.0.0.0\", () => {' | Set-Content 'server\server.js'"
        echo ✓ Server configured for external access
    ) else (
        echo ✓ Server already configured for external access
    )
) else (
    echo Error: server\server.js not found!
    pause
    exit /b 1
)

:: Create environment file for client
echo [3/3] Creating environment configuration...
echo HOST=0.0.0.0 > client\.env
echo GENERATE_SOURCEMAP=false >> client\.env
echo REACT_APP_SERVER_URL=http://%COMPUTER_IP%:5000 >> client\.env
echo ✓ Environment file created

echo.
echo ========================================
echo    Setup Complete!
echo ========================================
echo.
echo Your Sign Board Scanner is now configured for phone access.
echo.
echo 📱 PHONE ACCESS INSTRUCTIONS:
echo.
echo 1. Make sure your phone and computer are on the SAME WiFi network
echo.
echo 2. Start the application by running: start-for-phone.bat
echo    (This will be created for you)
echo.
echo 3. On your phone, open any browser and go to:
echo    http://%COMPUTER_IP%:3000
echo.
echo 4. You can now use the Sign Board Scanner on your phone!
echo    - Camera scanning will work on mobile
echo    - Upload images from your phone gallery
echo    - All features optimized for mobile use
echo.

:: Create a convenient start script for phone access
echo Creating start script for phone access...
(
echo @echo off
echo echo ========================================
echo echo    Starting Sign Board Scanner for Phone Access
echo echo ========================================
echo echo.
echo echo Your phone can access the app at:
echo echo http://%COMPUTER_IP%:3000
echo echo.
echo echo Make sure your phone is on the same WiFi network!
echo echo.
echo echo Starting server and client...
echo echo.
echo start "Sign Board Scanner Server" cmd /k "cd server && npm start"
echo timeout /t 3 ^>nul
echo start "Sign Board Scanner Client" cmd /k "cd client && npm start"
echo echo.
echo echo ========================================
echo echo    App Started! 
echo echo ========================================
echo echo.
echo echo 📱 On your phone, open browser and go to:
echo echo    http://%COMPUTER_IP%:3000
echo echo.
echo echo ✓ Camera scanning will work on mobile
echo echo ✓ Upload from phone gallery available  
echo echo ✓ All features mobile-optimized
echo echo.
echo echo Press any key to open the app on this computer too...
echo pause ^>nul
echo start http://localhost:3000
) > start-for-phone.bat

echo ✓ Created start-for-phone.bat
echo.
echo ========================================
echo    Ready to Use!
echo ========================================
echo.
echo Quick Start:
echo 1. Run: start-for-phone.bat
echo 2. On phone: http://%COMPUTER_IP%:3000
echo.
echo Features that work great on phone:
echo ✓ Camera scanning (uses phone's camera)
echo ✓ Photo upload from gallery
echo ✓ Touch-friendly interface
echo ✓ Real-time OCR processing
echo ✓ Copy results to clipboard
echo.
pause
