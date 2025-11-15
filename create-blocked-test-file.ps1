# create-blocked-test-file.ps1
# Generates a dummy PDF with a Zone.Identifier ADS so it appears "blocked" on Windows.

# Ensure this only runs meaningfully on Windows.
if (-not $IsWindows) {
    Write-Warning "This test script only applies on Windows. Other OSes do not support Zone.Identifier ADS."
    return
}

$targetDir = Join-Path (Get-Location) "test-files"
$targetFile = Join-Path $targetDir "dummy.pdf"

# 1. Ensure test directory exists
if (-not (Test-Path $targetDir)) {
    Write-Host "Creating directory: $targetDir"
    New-Item -Path $targetDir -ItemType Directory | Out-Null
}

# 2. Create a basic PDF-like file (still just text, but fine for zone testing)
Write-Host "Creating dummy file: $targetFile"
"Hello world" | Set-Content -Path $targetFile -Encoding UTF8

# 3. Add ADS to simulate downloaded-from-internet status
$zoneData = @"
[ZoneTransfer]
ZoneId=3
"@

Write-Host "Attaching Zone.Identifier ADS..."
Set-Content -Path $targetFile -Stream Zone.Identifier -Value $zoneData

Write-Host "Test file created and marked as blocked." -ForegroundColor Green
