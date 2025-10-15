# Create Working Desktop Icon for Transliterate Bharat
Write-Host "Creating working desktop icon..." -ForegroundColor Green

# Remove old shortcuts
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$OldShortcuts = @(
    "Transliterate Bharat.lnk",
    "Transliterate.lnk"
)

foreach ($shortcut in $OldShortcuts) {
    $OldPath = Join-Path $DesktopPath $shortcut
    if (Test-Path $OldPath) {
        Remove-Item $OldPath -Force
        Write-Host "Removed old shortcut: $shortcut" -ForegroundColor Yellow
    }
}

# Create new working shortcut
$AppName = "Transliterate Bharat"
$ShortcutPath = Join-Path $DesktopPath "$AppName.lnk"
$LauncherPath = Join-Path $PSScriptRoot "launch-transliterate-app.bat"

# Create shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

$Shortcut.TargetPath = $LauncherPath
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Indian Script Transliteration App"
$Shortcut.WindowStyle = 7

# Set icon
$IcoPath = Join-Path $PSScriptRoot "app-icon.ico"
if (Test-Path $IcoPath) {
    $Shortcut.IconLocation = "$IcoPath,0"
    Write-Host "Custom icon applied" -ForegroundColor Green
} else {
    $Shortcut.IconLocation = "%SystemRoot%\System32\shell32.dll,13"
    Write-Host "Using default icon" -ForegroundColor Yellow
}

$Shortcut.Save()

# Clean up
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {}

Write-Host ""
Write-Host "SUCCESS: Desktop icon created!" -ForegroundColor Green
Write-Host "Location: $ShortcutPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "How to use:" -ForegroundColor Yellow
Write-Host "1. Double-click the desktop icon" -ForegroundColor White
Write-Host "2. App will start automatically" -ForegroundColor White
Write-Host "3. Opens in Chrome app mode" -ForegroundColor White
Write-Host ""
Write-Host "Test it now by double-clicking the desktop icon!" -ForegroundColor Cyan
