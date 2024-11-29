# VaultCopy

Quickly make a copy of something to some destination with date + time added to title and adjustable auto deletion of old copies.

This is a quite simple PowerShell script for copying the contents of one destination to another. I made it for backing up my Obsidian vault, but it could be useful for backing up anything, and possibly other purposes as well.

Please read the [disclaimer](#disclaimer) too.

## Instructions

1. Edit the target for `runVaultCopy.exe`, so it matches your destination for `vaultCopy.ps1` and runs it through PowerShell :
   - Make sure you have PowerShell installed
   - Open the properties for `runVaultCopy.exe` (right click > Properties)
   - Replace "YOUR PATH HERE" with the path to the folder, in which `vaultCopy.ps1` is located (without removing "\vaultCopy.ps1")
   - Make sure that the PowerShell path is correct for both target and "Start in:"

![runVaultCopy file properties](https://i.imgur.com/MChIR8u.png)

2. Now the launcher knows where to look for the script, next tell the script which folder you want to copy (source), and where to copy it to (destination) :
   - Open `vaultCopy.ps1` in a text editor (eg. vscode)
   - Set the source and destination
   - Optionally adjust the `maxCopies` value set how many copies should be kept

```ps1
# § Set the source path (eg. C:\...\obsidian\vault-name) :
$source = "C:\..."

# § Set the destination path (where source content will be copied to) :
$destination = "C:\..."

# § Oldest copy will be deleted, when the number of existing copies is greater than or equal to this value :
$maxCopies = 20
```

3. Launch `runVaultCopy.exe`, wait a bit for it to execute, and when the empty terminal window closes (don't close it manually) a copy should have been added to the given destination.


## Disclaimer

This is my first PowerShell project, and I did it with a lot of help from an LLM. So I can't guarantee that the code is flawless. Actually i can guarantee that it isn't.

*Contributions are welcome, as well as any feedback!* Though it's not likely that I will spend much more time on this.

Obvious possible improvements include:

  - Fixing that all copies that don't have duplicated titles have "_1" as suffix (number will increase if an existing copy with same title was found, i.e. if two copies are made within the same minute).
  - Option to write paths that are relative to the script location, for source and / or destination.
  - Some user feedback for whether script ran successfully or an error occured

