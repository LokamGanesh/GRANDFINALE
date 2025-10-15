# Simple Icon Update Script
Write-Host "Updating desktop icon..." -ForegroundColor Green

# Paths
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$AppName = "Transliterate Bharat"
$ShortcutPath = Join-Path $DesktopPath "$AppName.lnk"
$LauncherPath = Join-Path $PSScriptRoot "launch-transliterate-app.bat"

# Remove old shortcut
if (Test-Path $ShortcutPath) {
    Remove-Item $ShortcutPath -Force
    Write-Host "Removed old shortcut" -ForegroundColor Yellow
}

# Clear icon cache by restarting Explorer
Write-Host "Refreshing icon cache..." -ForegroundColor Cyan
try {
    Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Start-Process "explorer.exe"
    Start-Sleep -Seconds 3
} catch {
    Write-Host "Could not restart Explorer" -ForegroundColor Yellow
}

# Create new shortcut
Write-Host "Creating new shortcut..." -ForegroundColor Cyan

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

$Shortcut.TargetPath = $LauncherPath
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Globe Translation App"
$Shortcut.WindowStyle = 7

# Try to use the SVG icon directly or fallback to shell icon
$SvgPath = Join-Path $PSScriptRoot "client\public\icon.svg"
if (Test-Path $SvgPath) {
    # Use a translation-related system icon
    $Shortcut.IconLocation = "%SystemRoot%\System32\shell32.dll,278"
} else {
    $Shortcut.IconLocation = "%SystemRoot%\System32\shell32.dll,13"
}

$Shortcut.Save()

# Clean up
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {}

Write-Host ""
Write-Host "SUCCESS: Desktop icon updated!" -ForegroundColor Green
Write-Host "Location: $ShortcutPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Note: Windows may take a few moments to refresh the icon." -ForegroundColor Yellow
Write-Host "If the old icon persists, try:" -ForegroundColor Yellow
Write-Host "1. Right-click desktop -> Refresh" -ForegroundColor White
Write-Host "2. Restart your computer" -ForegroundColor White
Write-Host ""
