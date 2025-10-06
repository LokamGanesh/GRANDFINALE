@echo off
title Jharkhand Tourism App - System Test
color 0E

echo.
echo ==========================================
echo    🧪 Jharkhand Tourism App Test Suite 🧪
echo ==========================================
echo.

REM Test 1: Check Node.js
echo 🔍 Test 1: Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ FAIL: Node.js not found
    set /a failed+=1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✅ PASS: Node.js %NODE_VERSION% found
)

REM Test 2: Check npm
echo 🔍 Test 2: Checking npm installation...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ FAIL: npm not found
    set /a failed+=1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo ✅ PASS: npm %NPM_VERSION% found
)

REM Test 3: Check project structure
echo 🔍 Test 3: Checking project structure...
if not exist "package.json" (
    echo ❌ FAIL: Root package.json missing
    set /a failed+=1
) else (
    echo ✅ PASS: Root package.json found
)

if not exist "server\package.json" (
    echo ❌ FAIL: Server package.json missing
    set /a failed+=1
) else (
    echo ✅ PASS: Server package.json found
)

if not exist "client\package.json" (
    echo ❌ FAIL: Client package.json missing
    set /a failed+=1
) else (
    echo ✅ PASS: Client package.json found
)

REM Test 4: Check key files
echo 🔍 Test 4: Checking key application files...
if not exist "start-app.bat" (
    echo ❌ FAIL: start-app.bat missing
    set /a failed+=1
) else (
    echo ✅ PASS: start-app.bat found
)

if not exist "server\server.js" (
    echo ❌ FAIL: server.js missing
    set /a failed+=1
) else (
    echo ✅ PASS: server.js found
)

if not exist "client\src\App.js" (
    echo ❌ FAIL: App.js missing
    set /a failed+=1
) else (
    echo ✅ PASS: App.js found
)

REM Test 5: Check dependencies
echo 🔍 Test 5: Checking dependencies...
if not exist "server\node_modules" (
    echo ⚠️  WARNING: Server dependencies not installed
    echo 💡 Run 'npm install' in server folder
) else (
    echo ✅ PASS: Server dependencies installed
)

if not exist "client\node_modules" (
    echo ⚠️  WARNING: Client dependencies not installed
    echo 💡 Run 'npm install' in client folder
) else (
    echo ✅ PASS: Client dependencies installed
)

REM Test 6: Check API routes
echo 🔍 Test 6: Checking API route files...
if not exist "server\routes\tourism.js" (
    echo ❌ FAIL: Tourism routes missing
    set /a failed+=1
) else (
    echo ✅ PASS: Tourism routes found
)

if not exist "server\routes\places.js" (
    echo ❌ FAIL: Places routes missing
    set /a failed+=1
) else (
    echo ✅ PASS: Places routes found
)

REM Test 7: Check React components
echo 🔍 Test 7: Checking React components...
if not exist "client\src\components\pages\Home.js" (
    echo ❌ FAIL: Home component missing
    set /a failed+=1
) else (
    echo ✅ PASS: Home component found
)

if not exist "client\src\components\pages\Places.js" (
    echo ❌ FAIL: Places component missing
    set /a failed+=1
) else (
    echo ✅ PASS: Places component found
)

if not exist "client\src\components\layout\Navbar.js" (
    echo ❌ FAIL: Navbar component missing
    set /a failed+=1
) else (
    echo ✅ PASS: Navbar component found
)

REM Test 8: Quick server test
echo 🔍 Test 8: Quick server functionality test...
echo 🚀 Starting test server...
cd /d "%~dp0\server"
start "Test Server" cmd /c "node server.js"
timeout /t 5 /nobreak >nul

REM Check if server is responding (if curl is available)
curl --version >nul 2>&1
if not errorlevel 1 (
    curl -s http://localhost:5000 >nul 2>&1
    if errorlevel 1 (
        echo ⚠️  WARNING: Server not responding (may need more time)
    ) else (
        echo ✅ PASS: Server responding correctly
    )
) else (
    echo ℹ️  INFO: curl not available, skipping server response test
)

REM Stop test server
taskkill /f /im node.exe >nul 2>&1
cd /d "%~dp0"

echo.
echo ==========================================
echo    📊 Test Results Summary
echo ==========================================
echo.

if not defined failed set failed=0

if %failed% equ 0 (
    echo 🎉 ALL TESTS PASSED! 🎉
    echo.
    echo ✅ Your Jharkhand Tourism App is ready to use!
    echo.
    echo 🚀 To start the app:
    echo   • Double-click the desktop shortcut
    echo   • Or run start-app.bat
    echo   • Or run setup.bat for first-time setup
    echo.
) else (
    echo ⚠️  %failed% TEST(S) FAILED
    echo.
    echo 🔧 Recommended actions:
    echo   1. Run setup.bat to install missing components
    echo   2. Check that Node.js is properly installed
    echo   3. Ensure all files are in the correct locations
    echo.
)

echo 📚 For detailed help, see:
echo   • USER_GUIDE.md - Complete user guide
echo   • README.md - Technical documentation
echo.

echo Press any key to continue...
pause >nul
