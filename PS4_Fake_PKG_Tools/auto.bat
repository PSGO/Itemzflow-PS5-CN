@echo off
chcp 65001
REM Set the working directory to the location of the batch file
cd /d %~dp0

mkdir "PKG\output"
orbis-pub-cmd.exe img_extract --passcode 00000000000000000000000000000000 "PKG\0.pkg" "PKG\output"
echo Extraction completed.
powershell -command "Start-Sleep -Seconds 3"
echo ------------------

xcopy /Y /S "PKG\output\Sc0\*" "PKG\output\Image0\sce_sys"
echo Sc0 folder copied successfully.
powershell -command "Start-Sleep -Seconds 2"
echo ------------------

xcopy /Y /S "PKG\Custom\Image0\*" "PKG\output\Image0"
echo Custom\Image0 folder copied successfully.
powershell -command "Start-Sleep -Seconds 2"
echo ------------------

gengp4_app.exe "PKG\output\Image0"
echo GP4 file generated successfully.
powershell -command "Start-Sleep -Seconds 3"
echo ------------------

xcopy /Y "PKG\output\Image0.gp4" "%~dp0"
echo GP4 file copied successfully.
powershell -command "Start-Sleep -Seconds 2"
echo ------------------

orbis-pub-cmd.exe img_create --oformat pkg "Image0.gp4" "PKG\output"
echo PKG file generated successfully!
powershell -command "Start-Sleep -Seconds 5"
echo ------------------

pause
exit /b 0
