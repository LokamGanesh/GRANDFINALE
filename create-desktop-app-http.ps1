# Simple HTTP Desktop App Creator for Transliterate Bharat
param(
    [string]$AppName = "Transliterate Bharat",
    [string]$AppUrl = "http://localhost:3000"
)

Write-Host "🚀 Creating Desktop App (HTTP Version)..." -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

# Create a proper ICO file from PNG
function New-IcoFromPng {
    param($PngPath, $IcoPath)
    
    try {
        Add-Type -AssemblyName System.Drawing
        
        $png = [System.Drawing.Image]::FromFile($PngPath)
        $ico = [System.Drawing.Icon]::FromHandle($png.GetHicon())
        
        $fileStream = [System.IO.FileStream]::new($IcoPath, [System.IO.FileMode]::Create)
        $ico.Save($fileStream)
        $fileStream.Close()
        
        $png.Dispose()
        $ico.Dispose()
        
        Write-Host "✅ ICO file created: $IcoPath" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "⚠️  Could not create ICO file: $($_.Exception.Message)" -ForegroundColor Yellow
        return $false
    }
}

# Create paths
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "$AppName.lnk"
$PngIconPath = Join-Path $PSScriptRoot "client\public\logo192.png"
$IcoIconPath = Join-Path $PSScriptRoot "app-icon.ico"

# Create ICO file from PNG
if (Test-Path $PngIconPath) {
    Write-Host "🎨 Creating icon file..." -ForegroundColor Cyan
    $iconCreated = New-IcoFromPng -PngPath $PngIconPath -IcoPath $IcoIconPath
} else {
    Write-Host "⚠️  PNG icon not found, using default icon" -ForegroundColor Yellow
    $iconCreated = $false
}

# Find Chrome first (best app mode support)
$BrowserPath = ""
$BrowserName = ""
$AppArgs = ""

$ChromePaths = @(
    "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "${env:LOCALAPPDATA}\Google\Chrome\Application\chrome.exe"
)

foreach ($path in $ChromePaths) {
    if (Test-Path $path) {
        $BrowserPath = $path
        $BrowserName = "Chrome"
        $AppArgs = "--app=$AppUrl --new-window --no-first-run --disable-background-timer-throttling"
        break
    }
}

# Try Edge if Chrome not found
if ($BrowserPath -eq "") {
    $EdgePaths = @(
        "${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe",
        "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
    )
    
    foreach ($path in $EdgePaths) {
        if (Test-Path $path) {
            $BrowserPath = $path
            $BrowserName = "Edge"
            $AppArgs = "--app=$AppUrl --new-window"
            break
        }
    }
}

# Fallback to default browser
if ($BrowserPath -eq "") {
    $BrowserPath = "explorer.exe"
    $BrowserName = "Default Browser"
    $AppArgs = $AppUrl
}

Write-Host "🔧 Using browser: $BrowserName" -ForegroundColor Cyan

# Create WScript Shell object
$WScriptShell = New-Object -ComObject WScript.Shell

# Create desktop shortcut
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $BrowserPath
$Shortcut.Arguments = $AppArgs
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Indian Script Transliteration App"
$Shortcut.WindowStyle = 1

# Set custom icon if available
if ($iconCreated -and (Test-Path $IcoIconPath)) {
    $Shortcut.IconLocation = "$IcoIconPath,0"
    Write-Host "🎨 Custom icon applied" -ForegroundColor Green
} else {
    $Shortcut.IconLocation = "$BrowserPath,0"
    Write-Host "🎨 Using browser icon" -ForegroundColor Yellow
}

$Shortcut.Save()

# Create Start Menu shortcut
$StartMenuPath = Join-Path ([Environment]::GetFolderPath("StartMenu")) "Programs"
$StartMenuShortcut = Join-Path $StartMenuPath "$AppName.lnk"

try {
    $StartMenuShortcutObj = $WScriptShell.CreateShortcut($StartMenuShortcut)
    $StartMenuShortcutObj.TargetPath = $Shortcut.TargetPath
    $StartMenuShortcutObj.Arguments = $Shortcut.Arguments
    $StartMenuShortcutObj.WorkingDirectory = $Shortcut.WorkingDirectory
    $StartMenuShortcutObj.Description = $Shortcut.Description
    $StartMenuShortcutObj.IconLocation = $Shortcut.IconLocation
    $StartMenuShortcutObj.WindowStyle = 1
    $StartMenuShortcutObj.Save()
    
    Write-Host "✅ Start Menu shortcut created!" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Could not create Start Menu shortcut: $($_.Exception.Message)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Desktop App Created Successfully!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "📍 Desktop Shortcut: $ShortcutPath" -ForegroundColor Cyan
Write-Host "📍 Start Menu: $StartMenuShortcut" -ForegroundColor Cyan
Write-Host "🌐 App URL: $AppUrl" -ForegroundColor Cyan
Write-Host "🔧 Browser: $BrowserName" -ForegroundColor Cyan
if ($iconCreated) {
    Write-Host "🎨 Custom Icon: Applied" -ForegroundColor Green
} else {
    Write-Host "🎨 Icon: Browser Default" -ForegroundColor Yellow
}
Write-Host ""
Write-Host "🚀 How to Use:" -ForegroundColor Yellow
Write-Host "   1. Run: start-app-simple.bat" -ForegroundColor White
Write-Host "   2. Or double-click: '$AppName' on desktop" -ForegroundColor White
Write-Host "   3. App opens in dedicated window" -ForegroundColor White
Write-Host ""
Write-Host "💡 Pro Tips:" -ForegroundColor Cyan
Write-Host "   • Right-click desktop icon → Pin to taskbar" -ForegroundColor White
Write-Host "   • Use start-app-simple.bat for automatic startup" -ForegroundColor White
Write-Host "   • No HTTPS issues - works reliably" -ForegroundColor White
Write-Host ""

# Clean up COM objects safely
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    if ($StartMenuShortcutObj) {
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($StartMenuShortcutObj) | Out-Null
    }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {
    # Ignore cleanup errors
}

Write-Host "Press any key to continue..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
