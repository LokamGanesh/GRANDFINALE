# Simple PowerShell script to create desktop shortcut for Transliterate Bharat App

Write-Host "Creating desktop shortcut for Transliterate Bharat App..." -ForegroundColor Green

# Get paths
$currentDir = Get-Location
$appPath = Join-Path $currentDir "start-app.bat"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "Transliterate Bharat.lnk"

# Remove old tourism shortcut if it exists
$oldShortcut = Join-Path $desktopPath "Jharkhand Tourism.lnk"
if (Test-Path $oldShortcut) {
    Remove-Item $oldShortcut
    Write-Host "Removed old tourism shortcut" -ForegroundColor Yellow
}

# Check if start-app.bat exists
if (-not (Test-Path $appPath)) {
    Write-Host "ERROR: start-app.bat not found!" -ForegroundColor Red
    exit 1
}

# Create shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $appPath
$shortcut.WorkingDirectory = $currentDir.Path
$shortcut.Description = "Transliterate Bharat - Indian Script Transliteration"
$shortcut.IconLocation = "shell32.dll,23"
$shortcut.Save()

Write-Host "Desktop shortcut created successfully!" -ForegroundColor Green
Write-Host "Location: $shortcutPath" -ForegroundColor White
Write-Host "You can now double-click 'Transliterate Bharat' on your desktop to launch the app!" -ForegroundColor Cyan
