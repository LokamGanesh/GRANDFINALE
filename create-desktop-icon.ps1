# Create desktop shortcut for Transliterate Bharat

$currentDir = Get-Location
$appPath = Join-Path $currentDir "launch-transliterate.bat"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "Transliterate Bharat.lnk"

# Remove any old shortcuts
$oldShortcuts = @(
    (Join-Path $desktopPath "Jharkhand Tourism.lnk"),
    $shortcutPath
)

foreach ($oldShortcut in $oldShortcuts) {
    if (Test-Path $oldShortcut) {
        Remove-Item $oldShortcut -Force
        Write-Host "Removed old shortcut: $oldShortcut" -ForegroundColor Yellow
    }
}

# Create new shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $appPath
$shortcut.WorkingDirectory = $currentDir.Path
$shortcut.Description = "Transliterate Bharat - Indian Script Transliteration App"
$shortcut.IconLocation = "shell32.dll,23"
$shortcut.Save()

Write-Host "Desktop shortcut created: Transliterate Bharat" -ForegroundColor Green
Write-Host "Location: $shortcutPath" -ForegroundColor White
