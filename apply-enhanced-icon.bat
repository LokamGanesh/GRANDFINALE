@echo off
echo ========================================
echo    Enhanced Sign Board Scanner Icon
echo    Applying New App Icon
echo ========================================
echo.

:: Check if we're in the right directory
if not exist "client\public" (
    echo Error: client\public directory not found!
    echo Please run this script from the transliterateAPP root directory.
    pause
    exit /b 1
)

:: Create the icon HTML file if it doesn't exist
echo Creating enhanced icon generator...
if not exist "create-custom-icon-from-image.html" (
    echo Error: Icon generator HTML file not found!
    pause
    exit /b 1
)

:: Open the icon generator in default browser
echo Opening enhanced icon generator...
start "" "create-custom-icon-from-image.html"

echo.
echo Instructions:
echo 1. The icon generator will open in your browser
echo 2. Download the generated PNG files (especially logo192.png and logo512.png)
echo 3. Copy the downloaded PNG files to client\public\ folder
echo 4. Replace the existing logo192.png and logo512.png files
echo 5. Run this script again to complete the icon update
echo.

:: Check if icon files exist in public folder
if exist "client\public\logo192.png" (
    echo Found existing logo192.png
    set /p replace="Replace existing icon files? (y/n): "
    if /i "%replace%"=="y" (
        goto :update_manifest
    ) else (
        echo Icon update cancelled.
        pause
        exit /b 0
    )
) else (
    echo Waiting for icon files to be placed in client\public\...
    echo Press any key after copying the new icon files...
    pause
)

:update_manifest
echo.
echo Updating app manifest and favicon...

:: Update the manifest.json to use new icons
if exist "client\public\manifest.json" (
    echo Updating manifest.json...
    
    :: Create backup
    copy "client\public\manifest.json" "client\public\manifest.json.backup" >nul
    
    :: Update manifest (basic replacement)
    powershell -Command "(Get-Content 'client\public\manifest.json') -replace '\"name\":\s*\".*?\"', '\"name\": \"Sign Board Scanner\"' -replace '\"short_name\":\s*\".*?\"', '\"short_name\": \"SignScanner\"' | Set-Content 'client\public\manifest.json'"
    
    echo Manifest updated successfully!
) else (
    echo Warning: manifest.json not found
)

:: Copy icon as favicon
if exist "client\public\logo192.png" (
    echo Setting favicon...
    copy "client\public\logo192.png" "client\public\favicon.ico" >nul
    echo Favicon updated!
)

:: Update desktop shortcut if it exists
echo.
echo Updating desktop shortcut icon...

:: Find desktop shortcut
set "desktop=%USERPROFILE%\Desktop"
if exist "%desktop%\Transliterate App.lnk" (
    echo Found desktop shortcut, updating icon...
    
    :: Use PowerShell to update shortcut icon
    powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%desktop%\Transliterate App.lnk'); $Shortcut.IconLocation = '%CD%\client\public\logo192.png'; $Shortcut.Save()"
    
    echo Desktop shortcut icon updated!
) else (
    echo Desktop shortcut not found, skipping...
)

:: Clear icon cache to force Windows to refresh
echo.
echo Refreshing Windows icon cache...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo ========================================
echo    Icon Update Complete!
echo ========================================
echo.
echo Your app now has the enhanced sign board scanner icon!
echo.
echo Changes made:
echo - Updated app icons (192x192, 512x512)
echo - Updated favicon
echo - Updated manifest.json
echo - Updated desktop shortcut (if found)
echo - Refreshed Windows icon cache
echo.
echo The new icon features:
echo - Modern gradient background
echo - Camera/scanner frame design
echo - OCR scan lines
echo - Translation arrow (अ → A)
echo - "OCR" label for clarity
echo.
pause
