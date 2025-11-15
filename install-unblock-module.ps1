$repoUrl = "https://github.com/ZaLiTHkA/UnblockFiles/archive/refs/heads/main.zip"

$zipPath      = "$env:TEMP\UnblockFiles.zip"
$extractPath  = "$env:TEMP\UnblockFilesExtracted"
$moduleTarget = "$env:USERPROFILE\Documents\PowerShell\Modules\UnblockFiles"

#########################################
# 1. Ensure PSMenu is installed
#########################################

$psmenuInstalled = Get-Module -ListAvailable -Name PSMenu

if (-not $psmenuInstalled) {
  Write-Host "PSMenu not found — installing..." -ForegroundColor Yellow

  try {
    Install-Module PSMenu -Scope CurrentUser -Force -ErrorAction Stop
    Write-Host "PSMenu installed successfully." -ForegroundColor Green
  }
  catch {
    Write-Host "Failed to install PSMenu: $($_.Exception.Message)" -ForegroundColor Red
    return
  }
}
else {
  Write-Host "PSMenu already installed." -ForegroundColor Green
}

#########################################
# 2. Download the module ZIP
#########################################

Write-Host "Downloading UnblockFiles module..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

#########################################
# 3. Extract the ZIP
#########################################

Write-Host "Extracting..." -ForegroundColor Cyan
if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

#########################################
# 4. Install module to user module folder
#########################################

Write-Host "Installing module..." -ForegroundColor Cyan

if (Test-Path $moduleTarget) {
  Remove-Item $moduleTarget -Recurse -Force
}

# Copy only the module folder from inside the archive
Copy-Item "$extractPath\UnblockFiles-main" $moduleTarget -Recurse -Force

#########################################
# 5. Load the UnblockFiles module
#########################################

Write-Host "Importing module..." -ForegroundColor Cyan

Import-Module UnblockFiles -Force

Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "You can now run the helper using:" -ForegroundColor Green
Write-Host "  Unblock-Files" -ForegroundColor Yellow
