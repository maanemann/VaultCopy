
# § Set the source path (eg. C:\...\obsidian\vault-name) :
$source = "C:\...\obsidian\vault-name"

# § Set the destination path (where source content will be copied to) :
$destination = "C:\..."

# § Oldest copy will be deleted, when the number of existing copies is greater than this value :
$maxCopies = 20

function Copy-With-DateRotation {
    param (
        [string]$srcPath,
        [string]$destPath,
        [int]$maxCopies
    )
    
    $sourceFolderName = Split-Path -Leaf $srcPath
    $dateFormat = "yyyyMMdd"
    $dateStr = (Get-Date).ToString($dateFormat)
    $baseDestFolderPath = Join-Path $destPath ("$sourceFolderName-$dateStr")

    # § Get existing copies :
    $existingCopies = Get-ChildItem -Path $destPath -Filter "$sourceFolderName-*" |
        Where-Object { $_.PSIsContainer -and $_.Name -match "$sourceFolderName-$dateStr(_\d+)?$" } |
        Sort-Object { $_.Name }

    $suffix = 0

    # § Find the highest suffix :
    foreach ($copy in $existingCopies) {
        if ($copy.Name -match "_(\d+)$") {
            $currentSuffix = [int]$matches[1]
            if ($currentSuffix -gt $suffix) {
                $suffix = $currentSuffix
            }
        } else {
            $suffix = 0
        }
    }

    # § Increment suffix to get a unique folder name :
    $suffix++
    $destFolderPath = "$baseDestFolderPath" + "_$suffix"

    # § If the number of existing copies is greater than or equal to the maximum, remove the oldest copy :
    if ($existingCopies.Count -ge $maxCopies) {
        $oldestCopy = $existingCopies[0]
        Remove-Item -Path $oldestCopy.FullName -Recurse -Force
    }

    # § Copy the source folder to the destination with the unique date suffix :
    Copy-Item -Path $srcPath -Destination $destFolderPath -Recurse -Force
}

Copy-With-DateRotation -srcPath $source -destPath $destination -maxCopies $maxCopies

