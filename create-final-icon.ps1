# Create Final Custom Icon for Desktop
Write-Host "🎨 Creating custom desktop icon..." -ForegroundColor Green

# Function to create a simple custom icon using .NET
function New-CustomIcon {
    param($OutputPath)
    
    try {
        Add-Type -AssemblyName System.Drawing
        
        # Create bitmap
        $size = 256
        $bitmap = New-Object System.Drawing.Bitmap($size, $size)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        
        # Colors
        $darkBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(26, 26, 26))
        $cyanPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(77, 208, 225), 4)
        $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $blueBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(38, 198, 218))
        $blackBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(51, 51, 51))
        
        # Draw rounded rectangle background
        $rect = New-Object System.Drawing.Rectangle(20, 20, 216, 216)
        $path = New-Object System.Drawing.Drawing2D.GraphicsPath
        $radius = 45
        
        # Create rounded rectangle path
        $path.AddArc($rect.X, $rect.Y, $radius * 2, $radius * 2, 180, 90)
        $path.AddArc($rect.Right - $radius * 2, $rect.Y, $radius * 2, $radius * 2, 270, 90)
        $path.AddArc($rect.Right - $radius * 2, $rect.Bottom - $radius * 2, $radius * 2, $radius * 2, 0, 90)
        $path.AddArc($rect.X, $rect.Bottom - $radius * 2, $radius * 2, $radius * 2, 90, 90)
        $path.CloseFigure()
        
        $graphics.FillPath($darkBrush, $path)
        
        # Draw globe (center circle)
        $center = $size / 2
        $globeRadius = 50
        $globeRect = New-Object System.Drawing.Rectangle(($center - $globeRadius), ($center - $globeRadius), ($globeRadius * 2), ($globeRadius * 2))
        
        # Globe outline
        $graphics.DrawEllipse($cyanPen, $globeRect)
        
        # Globe wireframe lines
        $innerRect1 = New-Object System.Drawing.Rectangle(($center - 20), ($center - $globeRadius), 40, ($globeRadius * 2))
        $innerRect2 = New-Object System.Drawing.Rectangle(($center - 35), ($center - $globeRadius), 70, ($globeRadius * 2))
        
        $graphics.DrawEllipse($cyanPen, $innerRect1)
        $graphics.DrawEllipse($cyanPen, $innerRect2)
        
        # Horizontal lines
        $graphics.DrawLine($cyanPen, ($center - $globeRadius), $center, ($center + $globeRadius), $center)
        
        # Speech bubbles
        # Left bubble (white)
        $bubble1 = New-Object System.Drawing.Rectangle(($center - 80), ($center - 60), 60, 40)
        $graphics.FillRectangle($whiteBrush, $bubble1)
        
        # Right bubble (blue)
        $bubble2 = New-Object System.Drawing.Rectangle(($center + 20), ($center + 20), 60, 40)
        $graphics.FillRectangle($blueBrush, $bubble2)
        
        # Add text
        $font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
        
        # "A" in white bubble
        $textRect1 = New-Object System.Drawing.Rectangle(($center - 65), ($center - 50), 30, 20)
        $format = New-Object System.Drawing.StringFormat
        $format.Alignment = [System.Drawing.StringAlignment]::Center
        $format.LineAlignment = [System.Drawing.StringAlignment]::Center
        $graphics.DrawString("A", $font, $blackBrush, $textRect1, $format)
        
        # Chinese character in blue bubble
        $textRect2 = New-Object System.Drawing.Rectangle(($center + 35), ($center + 30), 30, 20)
        $graphics.DrawString("文", $font, $whiteBrush, $textRect2, $format)
        
        # Save as PNG first
        $pngPath = "custom-icon.png"
        $bitmap.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
        
        # Convert to ICO
        $icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon())
        $fileStream = [System.IO.FileStream]::new($OutputPath, [System.IO.FileMode]::Create)
        $icon.Save($fileStream)
        $fileStream.Close()
        
        # Clean up
        $graphics.Dispose()
        $bitmap.Dispose()
        $darkBrush.Dispose()
        $cyanPen.Dispose()
        $whiteBrush.Dispose()
        $blueBrush.Dispose()
        $blackBrush.Dispose()
        $font.Dispose()
        $path.Dispose()
        $format.Dispose()
        $icon.Dispose()
        
        Write-Host "✅ Custom icon created: $OutputPath" -ForegroundColor Green
        return $true
        
    } catch {
        Write-Host "❌ Failed to create icon: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Create the custom icon
$IcoPath = Join-Path $PSScriptRoot "transliterate-custom.ico"
$success = New-CustomIcon -OutputPath $IcoPath

if (-not $success) {
    Write-Host "❌ Icon creation failed" -ForegroundColor Red
    exit 1
}

# Update desktop shortcut with custom icon
Write-Host "🔗 Updating desktop shortcut..." -ForegroundColor Cyan

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "Transliterate Bharat.lnk"
$LauncherPath = Join-Path $PSScriptRoot "launch-transliterate-app.bat"

# Remove old shortcut
if (Test-Path $ShortcutPath) {
    Remove-Item $ShortcutPath -Force
    Write-Host "🗑️ Removed old shortcut" -ForegroundColor Yellow
}

# Clear icon cache
Write-Host "🧹 Refreshing icon cache..." -ForegroundColor Cyan
try {
    Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Start-Process "explorer.exe"
    Start-Sleep -Seconds 3
} catch {
    Write-Host "⚠️ Could not restart Explorer" -ForegroundColor Yellow
}

# Create new shortcut with custom icon
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

$Shortcut.TargetPath = $LauncherPath
$Shortcut.WorkingDirectory = $PSScriptRoot
$Shortcut.Description = "Transliterate Bharat - Globe Translation App with Custom Icon"
$Shortcut.WindowStyle = 7
$Shortcut.IconLocation = "$IcoPath,0"

$Shortcut.Save()

# Clean up COM objects
try {
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($WScriptShell) | Out-Null
} catch {}

Write-Host ""
Write-Host "✅ CUSTOM ICON APPLIED!" -ForegroundColor Green
Write-Host "========================" -ForegroundColor Green
Write-Host ""
Write-Host "📍 Desktop Shortcut: $ShortcutPath" -ForegroundColor Cyan
Write-Host "🎨 Custom Icon: $IcoPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 Your icon now features:" -ForegroundColor Yellow
Write-Host "   • Dark rounded square background" -ForegroundColor White
Write-Host "   • Cyan globe wireframe" -ForegroundColor White
Write-Host "   • White speech bubble with 'A'" -ForegroundColor White
Write-Host "   • Blue speech bubble with '文'" -ForegroundColor White
Write-Host ""
Write-Host "💡 The custom icon should appear within 30 seconds!" -ForegroundColor Cyan
Write-Host "   If not visible, try right-clicking desktop and 'Refresh'" -ForegroundColor White
Write-Host ""
