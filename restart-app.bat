@echo off
echo ========================================
echo   🔄 Restarting Transliterate Bharat App
echo ========================================
echo.

echo 🛑 Stopping any running processes...
taskkill /f /im node.exe >nul 2>&1

echo ⏳ Waiting for processes to stop...
timeout /t 3 >nul

echo 🧹 Clearing browser cache (opening cache clear page)...
start chrome://settings/clearBrowserData

echo 🚀 Starting fresh app instance...
call start-app.bat

echo.
echo ✅ App restarted! 
echo 📝 Please clear your browser cache if you still see old content.
echo 🌐 App URL: http://localhost:3000
echo.
pause
