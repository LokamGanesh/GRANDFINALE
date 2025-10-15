@echo off
cls
echo ========================================
echo    📱 PHONE ACCESS - IP ADDRESS INFO
echo ========================================
echo.

:: Get the computer's IP address (exclude localhost and auto-assigned IPs)
echo Detecting your computer's IP address...
echo.

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "ip=%%a"
    set "ip=!ip: =!"
    
    :: Skip localhost and auto-assigned IPs
    echo !ip! | findstr /v "127.0.0.1" | findstr /v "169.254" >nul
    if not errorlevel 1 (
        echo 🌐 Your Computer's IP Address: !ip!
        echo.
        echo 📱 ACCESS FROM YOUR PHONE:
        echo    http://!ip!:3000
        echo.
        set "found_ip=!ip!"
    )
)

if not defined found_ip (
    echo ❌ Could not detect a valid IP address.
    echo    Make sure you're connected to WiFi.
    echo.
    echo Manual steps:
    echo 1. Go to Settings ^> Network ^> WiFi
    echo 2. Find your IP address
    echo 3. Use: http://YOUR_IP:3000
    echo.
    pause
    exit /b 1
)

echo ========================================
echo    🚀 QUICK START INSTRUCTIONS
echo ========================================
echo.
echo STEP 1: Make sure your phone and computer are on the SAME WiFi network
echo.
echo STEP 2: Start the app by running ONE of these:
echo   • Double-click: start-for-phone.bat
echo   • Or run: setup-phone-access.bat (first time setup)
echo.
echo STEP 3: On your phone, open any browser and go to:
echo   📱 http://!found_ip!:3000
echo.
echo ========================================
echo    📋 COPY THIS URL FOR YOUR PHONE
echo ========================================
echo.
echo http://!found_ip!:3000
echo.
echo ✓ Camera scanning works on mobile
echo ✓ Upload photos from phone gallery  
echo ✓ Touch-friendly interface
echo ✓ Real-time OCR processing
echo ✓ Copy results to phone clipboard
echo.

:: Try to copy to clipboard
echo http://!found_ip!:3000 | clip 2>nul
if not errorlevel 1 (
    echo 📋 URL copied to clipboard! You can paste it in your phone browser.
)

echo.
echo ========================================
echo    🔧 TROUBLESHOOTING
echo ========================================
echo.
echo If it doesn't work:
echo 1. Check both devices are on same WiFi
echo 2. Try turning off Windows Firewall temporarily
echo 3. Make sure the app is running (both server and client)
echo 4. Try http://!found_ip!:3000 in computer browser first
echo.
echo Need help? Run: setup-phone-access.bat for full setup
echo.
pause
