# Force Update Desktop Icon with New Design
Write-Host "🔄 Force updating desktop icon..." -ForegroundColor Green

# Function to create ICO from PNG
function New-IcoFromPng {
    param($PngPath, $IcoPath)
    
    try {
        Add-Type -AssemblyName System.Drawing
        
        # Load PNG and create icon
        $png = [System.Drawing.Image]::FromFile($PngPath)
        $bitmap = New-Object System.Drawing.Bitmap($png, 256, 256)
        $icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon())
        
        # Save as ICO
        $fileStream = [System.IO.FileStream]::new($IcoPath, [System.IO.FileMode]::Create)
        $icon.Save($fileStream)
        $fileStream.Close()
        
        # Clean up
        $png.Dispose()
        $bitmap.Dispose()
        $icon.Dispose()
        
        Write-Host "✅ ICO file created: $IcoPath" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "⚠️ Could not create ICO: $($_.Exception.Message)" -ForegroundColor Yellow
        return $false
    }
}

# Paths
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$AppName = "Transliterate Bharat"
$ShortcutPath = Join-Path $DesktopPath "$AppName.lnk"
$PngPath = Join-Path $PSScriptRoot "client\public\logo192.png"
$IcoPath = Join-Path $PSScriptRoot "app-icon-new.ico"

Write-Host "🎨 Checking for PNG file..." -ForegroundColor Cyan

# Check if PNG exists, if not create a simple one from SVG data
if (-not (Test-Path $PngPath)) {
    Write-Host "📝 Creating PNG from SVG..." -ForegroundColor Yellow
    
    # Create a simple PNG programmatically
    Add-Type -AssemblyName System.Drawing
    
    $bitmap = New-Object System.Drawing.Bitmap(192, 192)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    
    # Fill with dark background
    $darkBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(26, 26, 26))
    $graphics.FillRoundedRectangle($darkBrush, 10, 10, 172, 172, 30)
    
    # Draw globe circle
    $cyanPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(77, 208, 225), 3)
    $graphics.DrawEllipse($cyanPen, 56, 56, 80, 80)
    
    # Draw speech bubbles (simplified)
    $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $blueBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(38, 198, 218))
    
    $graphics.FillRectangle($whiteBrush, 40, 60, 40, 25)
    $graphics.FillRectangle($blueBrush, 112, 107, 40, 25)
    
    # Add text
    $font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $blackBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
    $graphics.DrawString("A", $font, $blackBrush, 55, 67)
    $graphics.DrawString("文", $font, $whiteBrush, 127, 114)
    
    # Save PNG
    $bitmap.Save($PngPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    # Clean up
    $graphics.Dispose()
    $bitmap.Dispose()
    $darkBrush.Dispose()
    $cyanPen.Dispose()
    $whiteBrush.Dispose()
    $blueBrush.Dispose()
    $font.Dispose()
    $blackBrush.Dispose()
    
    Write-Host "✅ PNG created: $PngPath" -ForegroundColor Green
}

# Generate new ICO file
Write-Host "🔧 Generating new ICO file..." -ForegroundColor Cyan
$iconCreated = New-IcoFromPng -PngPath $PngPath -IcoPath $IcoPath

if (-not $iconCreated) {
    Write-Host "❌ Failed to create ICO file" -ForegroundColor Red
    exit 1
}

# Clear Windows icon cache
Write-Host "🧹 Clearing Windows icon cache..." -ForegroundColor Cyan
try {
    # Delete icon cache files
    $iconCachePaths = @(
        "$env:LOCALAPPDATA\IconCache.db",
        "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache_*.db"
    )
    
    foreach ($path in $iconCachePaths) {
        if (Test-Path $path) {
            Remove-Item $path -Force -ErrorAction SilentlyContinue
        }
    }
    
    # Restart Explorer to refresh icons
    Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Start-Process "explorer.exe"
    
    Write-Host "✅ Icon cache cleared" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Could not clear icon cache: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Remove old shortcut
if (Test-Path $ShortcutPath) {
    Remove-Item $ShortcutPath -Force
    Write-Host "🗑️ Removed old shortcut" -ForegroundColor Yellow
}

# Wait a moment for Explorer to restart
Start-Sleep -Seconds 3

# Create new shortcut with new icon
Write-Host "🔗 Creating new shortcut..." -ForegroundColor Cyan

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

$LauncherPath = Join-Path $PSScriptRoot "launch-transliterate-app.bat"
$Shortcut.TargetPath = $LauncherPath
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Indian Script Transliteration App"
$Shortcut.WindowStyle = 7

# Set the new icon
$Shortcut.IconLocation = "$IcoPath,0"
$Shortcut.Save()

# Clean up COM objects
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {}

Write-Host ""
Write-Host "✅ DESKTOP ICON FORCE UPDATED!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "📍 Location: $ShortcutPath" -ForegroundColor Cyan
Write-Host "🎨 New Icon: $IcoPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "🔄 Changes made:" -ForegroundColor Yellow
Write-Host "   • Generated new ICO file with globe design" -ForegroundColor White
Write-Host "   • Cleared Windows icon cache" -ForegroundColor White
Write-Host "   • Restarted Explorer" -ForegroundColor White
Write-Host "   • Created fresh desktop shortcut" -ForegroundColor White
Write-Host ""
Write-Host "💡 The new icon should now be visible!" -ForegroundColor Cyan
Write-Host "   If not visible immediately, wait 30 seconds or restart PC" -ForegroundColor White
Write-Host ""
