# PowerShell Unblock File Helper

the sole purpose of this script is to simplify the process of running `Unblock-File` on one or more files in one or more potentially nested folders.

## Module Installation

this module is not currently published to the PSGallery, it may be one day, but for now it must be installed from this GitHub repo directly. a helper script has been added to this project to handle this process.

execute the following command in a PowerShell prompt to install it locally:

```
irm https://raw.githubusercontent.com/ZaLiTHkA/UnblockFiles/main/install.ps1 | iex
```

it will automatically invoke `Import-Module` at the end, so you may execute `Unblock-Files` immediately thereafter. but this is not a persistent change, so to import and use this module again in a new prompt, you will need to execute the following command first:

```
Import-Module UnblockFiles -Force
```

## Module Usage

this module is designed to be as flexible as possible, operating from the current working directory by default at runtime. but you may also provide a specific path to start from at launch.

```
UnblockFiles -Path <custom/working/directory>
```

when executed, this will first list all files and folders in the working directory. navigate the list with the up and down arrows, and use spacebar to toggle the inclusion of a file or folder.

- files will be processed directly
- folders will be processed recursively

if you need to limit the recursion depth in a folder, you may do so with the `-Depth` argument, such as the following which will only recurse 2 levels deep into folders:

```
UnblockFiles -Depth 2
```
