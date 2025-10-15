@echo off
echo ========================================
echo    Enable Mobile Camera Access
echo ========================================
echo.

echo The camera doesn't work on mobile because:
echo 1. Your current URL: http://192.168.0.134:3000
echo 2. Browsers block camera on HTTP + IP addresses
echo 3. Camera only works on HTTPS or localhost
echo.

echo ========================================
echo    SOLUTION 1: Use Chrome with Flags
echo ========================================
echo.
echo On your COMPUTER (not mobile):
echo 1. Close Chrome completely
echo 2. Run Chrome with this command:
echo.
echo chrome.exe --unsafely-treat-insecure-origin-as-secure=http://192.168.0.134:3000 --user-data-dir=temp-chrome
echo.
echo 3. Then access http://192.168.0.134:3000
echo 4. Camera should work now
echo.

echo ========================================
echo    SOLUTION 2: Mobile Browser Settings
echo ========================================
echo.
echo For Chrome Mobile:
echo 1. Go to chrome://flags/
echo 2. Search for "insecure origins"
echo 3. Enable "Insecure origins treated as secure"
echo 4. Add: http://192.168.0.134:3000
echo 5. Restart Chrome
echo.

echo ========================================
echo    SOLUTION 3: Use Upload Instead
echo ========================================
echo.
echo The UPLOAD feature works perfectly:
echo 1. Take photo with your phone camera
echo 2. Click "Upload Image" in the app
echo 3. Select the photo you took
echo 4. Same OCR results as live camera!
echo.

echo ========================================
echo    SOLUTION 4: Test on Computer
echo ========================================
echo.
echo On the SAME computer running the server:
echo 1. Open: http://localhost:3000
echo 2. Camera works perfectly
echo 3. All features available
echo.

echo ========================================
echo    CREATING MOBILE-FRIENDLY VERSION
echo ========================================
echo.
echo Creating a special mobile test page...

:: Create a simple mobile camera test
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Mobile Camera Test^</title^>
echo     ^<style^>
echo         body { font-family: Arial; padding: 20px; background: #f0f8ff; }
echo         .container { max-width: 500px; margin: 0 auto; }
echo         button { background: #007bff; color: white; border: none; padding: 15px 25px; border-radius: 8px; font-size: 16px; margin: 10px; cursor: pointer; }
echo         video { width: 100%%; max-width: 400px; border-radius: 10px; background: #000; }
echo         .error { background: #ffe6e6; padding: 15px; border-radius: 8px; color: #d00; margin: 10px 0; }
echo         .success { background: #e6ffe6; padding: 15px; border-radius: 8px; color: #060; margin: 10px 0; }
echo         .info { background: #e6f3ff; padding: 15px; border-radius: 8px; color: #006; margin: 10px 0; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<h1^>📱 Mobile Camera Test^</h1^>
echo         ^<div class="info"^>
echo             ^<strong^>Current URL:^</strong^> ^<span id="url"^>^</span^>^<br^>
echo             ^<strong^>Secure:^</strong^> ^<span id="secure"^>^</span^>^<br^>
echo             ^<strong^>Browser:^</strong^> ^<span id="browser"^>^</span^>
echo         ^</div^>
echo         
echo         ^<button onclick="testCamera()"^>🎥 Test Camera^</button^>
echo         ^<button onclick="stopCamera()" style="background: #dc3545;"^>⏹️ Stop^</button^>
echo         
echo         ^<video id="video" autoplay playsinline muted style="display: none;"^>^</video^>
echo         ^<div id="result"^>^</div^>
echo         
echo         ^<div class="info"^>
echo             ^<h3^>💡 If Camera Doesn't Work:^</h3^>
echo             ^<ul^>
echo                 ^<li^>Use the ^<strong^>Upload Image^</strong^> feature instead^</li^>
echo                 ^<li^>Take photos with your camera app^</li^>
echo                 ^<li^>Upload them to the transliteration app^</li^>
echo                 ^<li^>Same OCR results, no camera needed!^</li^>
echo             ^</ul^>
echo         ^</div^>
echo     ^</div^>
echo 
echo     ^<script^>
echo         document.getElementById('url'^).textContent = window.location.href;
echo         document.getElementById('secure'^).textContent = window.location.protocol === 'https:' ? '✅ HTTPS' : '❌ HTTP';
echo         document.getElementById('browser'^).textContent = navigator.userAgent.split(''^).pop(^);
echo         
echo         let stream = null;
echo         
echo         async function testCamera(^) {
echo             const video = document.getElementById('video'^);
echo             const result = document.getElementById('result'^);
echo             
echo             try {
echo                 result.innerHTML = '^<div class="info"^>🔄 Testing camera...^</div^>';
echo                 
echo                 stream = await navigator.mediaDevices.getUserMedia({
echo                     video: { facingMode: 'environment' }
echo                 }^);
echo                 
echo                 video.srcObject = stream;
echo                 video.style.display = 'block';
echo                 result.innerHTML = '^<div class="success"^>✅ Camera Working! You can use the main app camera feature.^</div^>';
echo                 
echo             } catch (err^) {
echo                 let msg = '';
echo                 if (err.name === 'NotAllowedError'^) {
echo                     msg = '🚫 Permission denied. Please allow camera access.';
echo                 } else if (err.name === 'NotSupportedError'^) {
echo                     msg = '⚠️ Camera not supported. Use HTTPS or upload images instead.';
echo                 } else {
echo                     msg = '❌ Camera failed: ' + err.message;
echo                 }
echo                 result.innerHTML = '^<div class="error"^>' + msg + '^</div^>';
echo             }
echo         }
echo         
echo         function stopCamera(^) {
echo             if (stream^) {
echo                 stream.getTracks(^).forEach(track =^> track.stop(^)^);
echo                 document.getElementById('video'^).style.display = 'none';
echo                 document.getElementById('result'^).innerHTML = '^<div class="info"^>📷 Camera stopped^</div^>';
echo             }
echo         }
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > client\public\mobile-camera-test.html

echo ✓ Created mobile-camera-test.html

echo.
echo ========================================
echo    MOBILE CAMERA TEST READY
echo ========================================
echo.
echo On your mobile, visit:
echo http://192.168.0.134:3000/mobile-camera-test.html
echo.
echo This will test camera access and show specific error messages.
echo.
echo ========================================
echo    RECOMMENDED APPROACH
echo ========================================
echo.
echo For reliable mobile OCR:
echo 1. ✅ Use "Upload Image" feature (always works)
echo 2. ✅ Take photos with phone camera app  
echo 3. ✅ Upload to transliteration app
echo 4. ✅ Get same OCR results as live camera
echo.
echo The upload feature is actually MORE reliable than live camera
echo because you can retake photos until they're perfect!
echo.
pause
