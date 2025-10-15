#!/usr/bin/env python3
"""
Generate Windows ICO file from SVG
Requires: pip install Pillow cairosvg
"""

import os
import sys
from io import BytesIO

try:
    import cairosvg
    from PIL import Image
except ImportError:
    print("Required packages not found. Installing...")
    os.system("pip install Pillow cairosvg")
    import cairosvg
    from PIL import Image

def svg_to_ico(svg_path, ico_path, sizes=[16, 32, 48, 64, 128, 256]):
    """Convert SVG to ICO with multiple sizes"""
    
    # Read SVG file
    with open(svg_path, 'r', encoding='utf-8') as f:
        svg_content = f.read()
    
    images = []
    
    for size in sizes:
        # Convert SVG to PNG at specific size
        png_data = cairosvg.svg2png(
            bytestring=svg_content.encode('utf-8'),
            output_width=size,
            output_height=size
        )
        
        # Create PIL Image
        img = Image.open(BytesIO(png_data))
        images.append(img)
        
        print(f"Generated {size}x{size} icon")
    
    # Save as ICO
    images[0].save(
        ico_path,
        format='ICO',
        sizes=[(img.width, img.height) for img in images],
        append_images=images[1:]
    )
    
    print(f"✅ ICO file created: {ico_path}")

def create_png_versions(svg_path, output_dir):
    """Create PNG versions for web use"""
    
    with open(svg_path, 'r', encoding='utf-8') as f:
        svg_content = f.read()
    
    sizes = [192, 512]
    
    for size in sizes:
        png_data = cairosvg.svg2png(
            bytestring=svg_content.encode('utf-8'),
            output_width=size,
            output_height=size
        )
        
        png_path = os.path.join(output_dir, f'logo{size}.png')
        with open(png_path, 'wb') as f:
            f.write(png_data)
        
        print(f"✅ Created: logo{size}.png")

if __name__ == "__main__":
    # Paths
    svg_path = "client/public/icon.svg"
    ico_path = "app-icon.ico"
    png_dir = "client/public"
    
    if not os.path.exists(svg_path):
        print(f"❌ SVG file not found: {svg_path}")
        sys.exit(1)
    
    try:
        # Generate ICO file
        svg_to_ico(svg_path, ico_path)
        
        # Generate PNG versions
        create_png_versions(svg_path, png_dir)
        
        print("\n🎉 All icon files generated successfully!")
        print(f"📁 ICO file: {ico_path}")
        print(f"📁 PNG files: {png_dir}/logo192.png, {png_dir}/logo512.png")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        print("💡 Make sure you have installed: pip install Pillow cairosvg")
        sys.exit(1)
