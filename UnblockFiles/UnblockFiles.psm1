function Get-FilesFromSelection {
    param(
        [Parameter(Mandatory)]
        [System.IO.FileSystemInfo[]]$Selection,

        [int]$Depth = [int]::MaxValue
    )

    $files = foreach ($item in $Selection) {
        if ($item.PSIsContainer) {
            Get-ChildItem -Path $item.FullName -File -Recurse -Depth $Depth
        } else {
            $item
        }
    }

    return $files
}

function Unblock-Files {
  param(
    [string]$Path = (Get-Location),
    [int]$Depth = [int]::MaxValue
  )

  if ($Depth -lt 0) {
    throw "Depth must be zero or greater."
  }

  # Non-recursive listing
  $options = Get-ChildItem -Path $Path

  # Create a hashtable mapping display names to full paths
  $displayMap = @{}
  foreach ($item in $options) {
    $displayName = $item.Name   # just the file/folder name
    # ensure uniqueness in the unlikely case of duplicate names
    $key = $displayName
    $i = 1
    while ($displayMap.ContainsKey($key)) {
      $i++
      $key = "$displayName ($i)"
    }
    $displayMap[$key] = $item.FullName
  }

  # Pass only the display names to PSMenu
  $selectionKeys = Show-Menu -MenuItems $displayMap.Keys -MultiSelect

  $selectionPaths = $selectionKeys | ForEach-Object { $displayMap[$_] }

  # Convert to FileSystemInfo objects for your recursion helper
  $selection = $selectionPaths | ForEach-Object { Get-Item $_ }

  if (-not $selection) {
    Write-Host "No entries selected for processing"
    return
  }

  # Step 2: expand folders into files
  $files = Get-FilesFromSelection -Selection $selection -Depth $Depth
  if (-not $files) {
    throw "Selected entries yielded no files to process"
  }
  Write-Host "You are about to unblock $($files.Count) files."
  if (-not (Read-Host "Continue? (y/N)").StartsWith('y')) { return }

  # Step 3: unblock all valid targets
  $files | Unblock-File
  Write-Host "Unblocked $($files.Count) files."
}

Export-ModuleMember -Function 'Unblock-Files'
