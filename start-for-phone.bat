@echo off
echo ========================================
echo    Starting Sign Board Scanner for Phone Access
echo ========================================
echo.
echo Your phone can access the app at:
echo http://!COMPUTER_IP: =!:3000
echo.
echo Make sure your phone is on the same WiFi network!
echo.
echo Starting server and client...
echo.
start "Sign Board Scanner Server" cmd /k "cd server && npm start"
timeout /t 3 >nul
start "Sign Board Scanner Client" cmd /k "cd client && npm start"
echo.
echo ========================================
echo    App Started! 
echo ========================================
echo.
echo 📱 On your phone, open browser and go to:
echo    http://!COMPUTER_IP: =!:3000
echo.
echo ✓ Camera scanning will work on mobile
echo ✓ Upload from phone gallery available  
echo ✓ All features mobile-optimized
echo.
echo Press any key to open the app on this computer too...
pause >nul
start http://localhost:3000
