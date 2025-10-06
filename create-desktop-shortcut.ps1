# PowerShell script to create desktop shortcut for Jharkhand Tourism App

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Jharkhand Tourism Desktop Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get the current directory
$currentDir = Get-Location
$appPath = Join-Path $currentDir "start-app.bat"

# Check if start-app.bat exists
if (-not (Test-Path $appPath)) {
    Write-Host "ERROR: start-app.bat not found!" -ForegroundColor Red
    Write-Host "Please make sure you're running this from the correct directory." -ForegroundColor Red
    pause
    exit 1
}

# Get desktop path
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "Jharkhand Tourism.lnk"

Write-Host "Creating desktop shortcut..." -ForegroundColor Yellow

try {
    # Create WScript Shell object
    $WScriptShell = New-Object -ComObject WScript.Shell

    # Create shortcut
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $appPath
    $shortcut.WorkingDirectory = $currentDir
    $shortcut.Description = "Jharkhand Tourism - Explore the Land of Forests"
    $shortcut.Arguments = ""
    
    # Use a tourism-related icon (world/globe icon)
    $shortcut.IconLocation = "shell32.dll,13"
    
    # Save the shortcut
    $shortcut.Save()

    Write-Host ""
    Write-Host "✅ SUCCESS!" -ForegroundColor Green
    Write-Host "Desktop shortcut created successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📍 Location: $shortcutPath" -ForegroundColor White
    Write-Host "🎯 Target: $appPath" -ForegroundColor White
    Write-Host ""
    Write-Host "🚀 You can now double-click the 'Jharkhand Tourism' icon on your desktop to launch the app!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "The app will automatically:" -ForegroundColor Yellow
    Write-Host "  • Start the backend server (port 5000)" -ForegroundColor Yellow
    Write-Host "  • Start the frontend client (port 3000)" -ForegroundColor Yellow
    Write-Host "  • Open your browser to http://localhost:3000" -ForegroundColor Yellow
    Write-Host ""
    
} catch {
    Write-Host "❌ ERROR: Failed to create desktop shortcut" -ForegroundColor Red
    Write-Host "Error details: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "Press any key to continue..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
