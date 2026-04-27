$current = (Get-Content package.json | ConvertFrom-Json).version
# Install dependencies
composer install --no-dev --prefer-dist --no-progress
Remove-Item vendor/bin -Recurse -Force
yarn
Write-Host "Dependencies have been installed." -ForegroundColor Green
./tools/build.ps1

$zip = "blessing-skin-server-$current.zip"
zip -9 -r $zip app bootstrap config database plugins public resources/lang resources/views resources/misc/textures routes storage vendor .env.example artisan LICENSE README.md README-zh.md index.html
Write-Host "Zip archive is created." -ForegroundColor Green

New-Item dist -ItemType Directory
Set-Location dist
Copy-Item -Path "../$zip" -Destination $zip

Write-Host "Update source is prepared." -ForegroundColor Green
