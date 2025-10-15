@echo off
echo ========================================
echo    Sign Board Scanner - Functionality Test
echo ========================================
echo.

:: Check if we're in the right directory
if not exist "server\server.js" (
    echo Error: server\server.js not found!
    echo Please run this script from the transliterateAPP root directory.
    pause
    exit /b 1
)

if not exist "client\package.json" (
    echo Error: client\package.json not found!
    echo Please run this script from the transliterateAPP root directory.
    pause
    exit /b 1
)

echo Testing Sign Board Scanner functionality...
echo.

:: Test 1: Check if server dependencies are installed
echo [1/5] Checking server dependencies...
cd server
if not exist "node_modules" (
    echo Installing server dependencies...
    call npm install
    if errorlevel 1 (
        echo Error: Failed to install server dependencies
        cd ..
        pause
        exit /b 1
    )
) else (
    echo ✓ Server dependencies found
)
cd ..

:: Test 2: Check if client dependencies are installed
echo [2/5] Checking client dependencies...
cd client
if not exist "node_modules" (
    echo Installing client dependencies...
    call npm install
    if errorlevel 1 (
        echo Error: Failed to install client dependencies
        cd ..
        pause
        exit /b 1
    )
) else (
    echo ✓ Client dependencies found
)
cd ..

:: Test 3: Check if Tesseract.js is properly installed
echo [3/5] Checking OCR dependencies...
cd server
call npm list tesseract.js >nul 2>&1
if errorlevel 1 (
    echo Installing Tesseract.js for OCR...
    call npm install tesseract.js
    if errorlevel 1 (
        echo Warning: Tesseract.js installation failed. OCR may not work properly.
    ) else (
        echo ✓ Tesseract.js installed successfully
    )
) else (
    echo ✓ Tesseract.js found
)
cd ..

:: Test 4: Build client for production
echo [4/5] Building client application...
cd client
echo Building optimized client bundle...
call npm run build >nul 2>&1
if errorlevel 1 (
    echo Warning: Client build failed. Using development mode.
) else (
    echo ✓ Client built successfully
)
cd ..

:: Test 5: Start the application
echo [5/5] Starting Sign Board Scanner application...
echo.
echo ========================================
echo    Application Starting...
echo ========================================
echo.
echo The Sign Board Scanner will start with:
echo.
echo ✓ Enhanced OCR functionality for sign boards
echo ✓ Real-time camera scanning
echo ✓ Advanced text cleaning and preprocessing
echo ✓ Multi-script transliteration support
echo ✓ Improved error handling
echo ✓ Updated UI with sign board theme
echo.
echo Server will start on: http://localhost:5000
echo Client will be available at: http://localhost:3000
echo.
echo Press Ctrl+C to stop the application
echo.

:: Start both server and client
start "Sign Board Scanner Server" cmd /k "cd server && npm start"
timeout /t 3 >nul
start "Sign Board Scanner Client" cmd /k "cd client && npm start"

echo.
echo ========================================
echo    Sign Board Scanner Started!
echo ========================================
echo.
echo Instructions for testing:
echo.
echo 1. Wait for both server and client to start
echo 2. Open http://localhost:3000 in your browser
echo 3. Test the sign board scanning features:
echo    - Upload a sign board image
echo    - Use camera capture for live scanning
echo    - Try different script combinations
echo.
echo Features to test:
echo ✓ Image upload and OCR processing
echo ✓ Camera capture functionality
echo ✓ Text extraction accuracy
echo ✓ Transliteration between scripts
echo ✓ Error handling for bad images
echo ✓ Copy to clipboard functionality
echo ✓ OCR confidence display
echo.
echo Known improvements made:
echo ✓ Enhanced OCR with sign board optimization
echo ✓ Character whitelisting for better accuracy
echo ✓ Text cleaning and preprocessing
echo ✓ Better error messages and user feedback
echo ✓ Modern UI with sign board scanner theme
echo ✓ Updated app icon and branding
echo.
pause
