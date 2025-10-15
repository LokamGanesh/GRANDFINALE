@echo off
echo Starting Transliterate Bharat with HTTPS support...
echo This enables camera access on both laptop and mobile devices.
echo.
echo Frontend will be available at: https://localhost:3000
echo Backend will be available at: http://localhost:5000
echo Mobile access: https://192.168.31.73:3000
echo.
echo Note: You may see a security warning - click "Advanced" and "Proceed to localhost"
echo.
npm run start:https
pause
