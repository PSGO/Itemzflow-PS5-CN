# 设置工作目录为当前脚本位置
Set-Location -Path $PSScriptRoot

# 创建输出文件夹
New-Item -ItemType Directory -Path "PKG\output" -Force
.\orbis-pub-cmd.exe img_extract --passcode 00000000000000000000000000000000 "PKG\PS5_ITEM00001.pkg" "PKG\output"
Write-Host "Extraction completed."
Start-Sleep -Seconds 10
Write-Host "------------------"

Copy-Item -Path "PKG\output\Sc0\*" -Destination "PKG\output\Image0\sce_sys" -Recurse -Force
Write-Host "Sc0 folder copied successfully."
Start-Sleep -Seconds 2
Write-Host "------------------"

Copy-Item -Path "PKG\Custom\Image0\*" -Destination "PKG\output\Image0" -Recurse -Force
Write-Host "Custom\Image0 folder copied successfully."
Start-Sleep -Seconds 2
Write-Host "------------------"

.\gengp4_app.exe "PKG\output\Image0"
Write-Host "GP4 file generated successfully."
Start-Sleep -Seconds 2
Write-Host "------------------"

Copy-Item -Path "PKG\output\Image0.gp4" -Destination $PSScriptRoot -Force
Write-Host "GP4 file copied successfully."
Start-Sleep -Seconds 2
Write-Host "------------------"

.\orbis-pub-cmd.exe img_create --oformat pkg "Image0.gp4" "PKG\output"
Write-Host "PKG file generated successfully!"
Start-Sleep -Seconds 10
Write-Host "------------------"

Pause
