# Fix Desktop Icon for Transliterate Bharat
Write-Host "🔧 Fixing Desktop Icon..." -ForegroundColor Green

# Remove old shortcut if exists
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$OldShortcuts = @(
    "Transliterate Bharat.lnk",
    "Transliterate भारत.lnk"
)

foreach ($shortcut in $OldShortcuts) {
    $OldPath = Join-Path $DesktopPath $shortcut
    if (Test-Path $OldPath) {
        Remove-Item $OldPath -Force
        Write-Host "🗑️ Removed old shortcut: $shortcut" -ForegroundColor Yellow
    }
}

# Create new working shortcut
$AppName = "Transliterate Bharat"
$ShortcutPath = Join-Path $DesktopPath "$AppName.lnk"
$LauncherPath = Join-Path $PSScriptRoot "launch-transliterate-app.bat"

# Create WScript Shell object
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

# Set shortcut properties to launch our batch file
$Shortcut.TargetPath = $LauncherPath
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Indian Script Transliteration App"
$Shortcut.WindowStyle = 7  # Minimized window

# Try to set custom icon
$IcoPath = Join-Path $PSScriptRoot "app-icon.ico"
if (Test-Path $IcoPath) {
    $Shortcut.IconLocation = "$IcoPath,0"
    Write-Host "🎨 Custom icon applied" -ForegroundColor Green
} else {
    # Use Windows default app icon
    $Shortcut.IconLocation = "%SystemRoot%\System32\shell32.dll,13"
    Write-Host "🎨 Using default app icon" -ForegroundColor Yellow
}

# Save the shortcut
$Shortcut.Save()

# Create Start Menu shortcut too
$StartMenuPath = Join-Path ([Environment]::GetFolderPath("StartMenu")) "Programs"
$StartMenuShortcut = Join-Path $StartMenuPath "$AppName.lnk"

try {
    $StartMenuShortcutObj = $WScriptShell.CreateShortcut($StartMenuShortcut)
    $StartMenuShortcutObj.TargetPath = $LauncherPath
    $StartMenuShortcutObj.WorkingDirectory = $PSScriptRoot
    $StartMenuShortcutObj.Description = $Shortcut.Description
    $StartMenuShortcutObj.IconLocation = $Shortcut.IconLocation
    $StartMenuShortcutObj.WindowStyle = 7
    $StartMenuShortcutObj.Save()
    
    Write-Host "✅ Start Menu shortcut created!" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Could not create Start Menu shortcut" -ForegroundColor Yellow
}

# Clean up COM objects
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {}

Write-Host ""
Write-Host "✅ Desktop Icon Fixed!" -ForegroundColor Green
Write-Host "======================" -ForegroundColor Green
Write-Host ""
Write-Host "📍 Location: $ShortcutPath" -ForegroundColor Cyan
Write-Host "🎯 Target: $LauncherPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "🚀 How it works:" -ForegroundColor Yellow
Write-Host "   1. Double-click desktop icon" -ForegroundColor White
Write-Host "   2. Automatically starts servers if needed" -ForegroundColor White
Write-Host "   3. Opens app in Chrome app mode" -ForegroundColor White
Write-Host "   4. Works every time!" -ForegroundColor White
Write-Host ""
Write-Host "Test it now: Double-click the desktop icon!" -ForegroundColor Cyan
Write-Host ""
