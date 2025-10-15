#!/usr/bin/env python3
"""
Create custom ICO file from our SVG design
"""
import os
import sys
from PIL import Image, ImageDraw, ImageFont
import io

def create_custom_icon():
    """Create a custom icon that matches our SVG design"""
    
    # Create a 256x256 image
    size = 256
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Colors
    dark_bg = (26, 26, 26, 255)  # Dark background
    cyan = (77, 208, 225, 255)   # Cyan for globe
    white = (255, 255, 255, 255) # White for speech bubble
    blue = (38, 198, 218, 255)   # Blue for speech bubble
    
    # Draw rounded rectangle background (iOS style)
    margin = 20
    corner_radius = 45
    
    # Create rounded rectangle
    def draw_rounded_rectangle(draw, coords, radius, fill):
        x1, y1, x2, y2 = coords
        draw.rectangle([x1 + radius, y1, x2 - radius, y2], fill=fill)
        draw.rectangle([x1, y1 + radius, x2, y2 - radius], fill=fill)
        draw.pieslice([x1, y1, x1 + 2*radius, y1 + 2*radius], 180, 270, fill=fill)
        draw.pieslice([x2 - 2*radius, y1, x2, y1 + 2*radius], 270, 360, fill=fill)
        draw.pieslice([x1, y2 - 2*radius, x1 + 2*radius, y2], 90, 180, fill=fill)
        draw.pieslice([x2 - 2*radius, y2 - 2*radius, x2, y2], 0, 90, fill=fill)
    
    # Draw background
    draw_rounded_rectangle(draw, [margin, margin, size-margin, size-margin], corner_radius, dark_bg)
    
    # Draw globe (center circle)
    center = size // 2
    globe_radius = 40
    
    # Globe outline
    draw.ellipse([center-globe_radius, center-globe_radius, 
                  center+globe_radius, center+globe_radius], 
                 outline=cyan, width=3)
    
    # Globe lines (simplified wireframe)
    # Vertical lines
    draw.ellipse([center-15, center-globe_radius, center+15, center+globe_radius], 
                 outline=cyan, width=2)
    draw.ellipse([center-30, center-globe_radius, center+30, center+globe_radius], 
                 outline=cyan, width=2)
    
    # Horizontal lines
    draw.line([center-globe_radius, center, center+globe_radius, center], 
              fill=cyan, width=2)
    draw.ellipse([center-globe_radius, center-15, center+globe_radius, center+15], 
                 outline=cyan, width=2)
    draw.ellipse([center-globe_radius, center-25, center+globe_radius, center+25], 
                 outline=cyan, width=2)
    
    # Speech bubbles
    # Left bubble (white with "A")
    bubble1_x, bubble1_y = center - 65, center - 45
    bubble1_w, bubble1_h = 50, 35
    
    draw_rounded_rectangle(draw, [bubble1_x, bubble1_y, bubble1_x+bubble1_w, bubble1_y+bubble1_h], 
                          8, white)
    
    # Bubble tail
    draw.polygon([(bubble1_x+8, bubble1_y+bubble1_h), 
                  (bubble1_x+15, bubble1_y+bubble1_h+10), 
                  (bubble1_x+20, bubble1_y+bubble1_h)], fill=white)
    
    # Right bubble (blue with Chinese character)
    bubble2_x, bubble2_y = center + 35, center + 25
    bubble2_w, bubble2_h = 50, 35
    
    draw_rounded_rectangle(draw, [bubble2_x, bubble2_y, bubble2_x+bubble2_w, bubble2_y+bubble2_h], 
                          8, blue)
    
    # Bubble tail (pointing up)
    draw.polygon([(bubble2_x+20, bubble2_y), 
                  (bubble2_x+25, bubble2_y-10), 
                  (bubble2_x+30, bubble2_y)], fill=blue)
    
    # Add text
    try:
        # Try to use a system font
        font_large = ImageFont.truetype("arial.ttf", 20)
        font_medium = ImageFont.truetype("arial.ttf", 18)
    except:
        # Fallback to default font
        font_large = ImageFont.load_default()
        font_medium = ImageFont.load_default()
    
    # Draw "A" in white bubble
    text_bbox = draw.textbbox((0, 0), "A", font=font_large)
    text_w = text_bbox[2] - text_bbox[0]
    text_h = text_bbox[3] - text_bbox[1]
    text_x = bubble1_x + (bubble1_w - text_w) // 2
    text_y = bubble1_y + (bubble1_h - text_h) // 2
    draw.text((text_x, text_y), "A", fill=(51, 51, 51, 255), font=font_large)
    
    # Draw Chinese character in blue bubble
    text_bbox = draw.textbbox((0, 0), "文", font=font_medium)
    text_w = text_bbox[2] - text_bbox[0]
    text_h = text_bbox[3] - text_bbox[1]
    text_x = bubble2_x + (bubble2_w - text_w) // 2
    text_y = bubble2_y + (bubble2_h - text_h) // 2
    draw.text((text_x, text_y), "文", fill=white, font=font_medium)
    
    return img

def save_as_ico(img, ico_path):
    """Save PIL image as ICO file with multiple sizes"""
    sizes = [16, 32, 48, 64, 128, 256]
    images = []
    
    for size in sizes:
        resized = img.resize((size, size), Image.Resampling.LANCZOS)
        images.append(resized)
    
    # Save as ICO
    images[0].save(ico_path, format='ICO', sizes=[(img.width, img.height) for img in images])
    print(f"✅ ICO file created: {ico_path}")

def main():
    print("🎨 Creating custom app icon...")
    
    # Create the icon
    icon_img = create_custom_icon()
    
    # Save as PNG for web use
    png_path = "client/public/logo192.png"
    os.makedirs(os.path.dirname(png_path), exist_ok=True)
    
    icon_192 = icon_img.resize((192, 192), Image.Resampling.LANCZOS)
    icon_192.save(png_path, format='PNG')
    print(f"✅ PNG file created: {png_path}")
    
    # Save larger PNG
    png_path_512 = "client/public/logo512.png"
    icon_512 = icon_img.resize((512, 512), Image.Resampling.LANCZOS)
    icon_512.save(png_path_512, format='PNG')
    print(f"✅ PNG file created: {png_path_512}")
    
    # Save as ICO for desktop
    ico_path = "app-icon-custom.ico"
    save_as_ico(icon_img, ico_path)
    
    print("\n🎉 Custom icon files created successfully!")
    print("📁 Files generated:")
    print(f"   • {png_path} (for web)")
    print(f"   • {png_path_512} (for web)")
    print(f"   • {ico_path} (for desktop)")

if __name__ == "__main__":
    main()
