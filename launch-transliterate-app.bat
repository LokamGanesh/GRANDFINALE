@echo off
cd /d "%~dp0"

REM Check if servers are running
netstat -an | findstr ":3000" >nul 2>&1
if %errorlevel% neq 0 (
    echo Starting Transliterate Bharat servers...
    start /min cmd /c "npm start"
    
    REM Wait for server to start
    :wait
    timeout /t 2 /nobreak >nul
    netstat -an | findstr ":3000" >nul 2>&1
    if %errorlevel% neq 0 goto wait
    
    timeout /t 3 /nobreak >nul
)

REM Launch the app in Chrome app mode
set CHROME_PATH=""
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
)

if not %CHROME_PATH%=="" (
    start "" %CHROME_PATH% --app=http://localhost:3000 --new-window --user-data-dir="%TEMP%\TransliterateApp"
) else (
    start "" "http://localhost:3000"
)
