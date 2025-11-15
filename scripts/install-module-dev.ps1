$repoUrl = "https://github.com/ZaLiTHkA/UnblockFiles/archive/refs/heads/develop.zip"

$zipPath = "$env:TEMP\UnblockFiles.zip"
$extractPath = "$env:TEMP\UnblockFilesExtracted"
$extractedModule = "$extractPath\UnblockFiles-develop"
$moduleTarget = "$env:USERPROFILE\Documents\PowerShell\Modules\UnblockFiles"

Write-Host "Starting Unblock-Files PS module installer (develop branch)" -ForegroundColor Green

Write-Host "Downloading UnblockFiles repository..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

Write-Host "Extracting GitHub archive..." -ForegroundColor Cyan
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

Write-Host "Installing module for current user..." -ForegroundColor Cyan
if (Test-Path $moduleTarget) {
  Write-Host "Existing module installation found!" -ForegroundColor Yellow
  if (-not (Read-Host "Replace the existing module installation? (y/N)").ToLower().StartsWith('y')) {
    Write-Host "Unable to continue, either remove the existing module first or allow this script to overwrite it." -ForegroundColor Red
    return
  }
  Remove-Item $moduleTarget -Recurse -Force
}
Copy-Item $extractedModule $moduleTarget -Recurse -Force

Write-Host "Cleaning up temp files..." -ForegroundColor Gray
if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }

Write-Host "Installation complete!" -ForegroundColor Green

if (-not (Read-Host "Would you like to import the module into your current session? (y/N)").ToLower().StartsWith('y')) {
  Write-Host "To use this module, execute the following command in any PowerShell session:" -ForegroundColor Green
  Write-Host "  Import-Module UnblockFiles" -ForegroundColor Blue
  return
}

Write-Host "Importing module..." -ForegroundColor Cyan
Import-Module UnblockFiles -Force

Write-Host "You can now run the helper using:" -ForegroundColor Green
Write-Host "  Unblock-Files" -ForegroundColor Blue
