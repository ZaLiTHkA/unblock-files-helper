# PowerShell Unblock File Helper

the sole purpose of this script is to simplify the process of running `Unblock-File` on one or more files in one or more potentially nested folders.

## Module Installation

this module is not currently published to the PSGallery, it may be one day, but for now it must be installed from this GitHub repo directly. a helper script has been added to this project to handle this process.

execute the following command in a PowerShell prompt to install it locally:

```pwsh
irm https://raw.githubusercontent.com/ZaLiTHkA/UnblockFiles/main/install-unblock-module.ps1 | iex
```

once installed, this module may be imported into any PowerShell session with the following command:

```pwsh
Import-Module UnblockFiles -Force
```

> NOTE: this is done automatically at the end of the installation, but it is not a persistent system change. you will need to call this again if you open a new terminal session.

## Basic Module Usage

by default, this script will operate on your current working directory. this can be changed, but we will get to that later.

the easiest way to use this, is to open a PowerShell session in the directory where you have files that you wish to unlock, and run the following command:

```pwsh
Unblock-Files
```

this will find all files and folders in the current working directory, and present a list of checkbox items for you to select.

- navigate with the arrow keys.
- toggle items with "spacebar".
- confirm selection with "enter".

if a folder is selected, the script will recurse into that folder and try to "unblock" every file it encounters.

at the end, you will see a message showing how many files were "unblock" in this way.

## Advanced Module Usage

if you cannot open a PowerShell session at the required path, you may provide this path at runtime with the `-Path` argument:

```pwsh
Unblock-Files -Path <custom/working/directory>
```

> NOTE: this path may be relative or absolute. if it contains spaces, enclose it with 'single quotes'.

if you need to limit the recursion depth in any folder, you may do so with the `-Depth` argument:

```pwsh
Unblock-Files -Depth 2
```

> NOTE: this depth check applies from the script's working directory.
