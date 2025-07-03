<#
.SYNOPSIS
Scans a document library for duplicate files by comparing file names and hash values.

.DESCRIPTION
Helpful before migration or for library cleanup.

.NOTES
Author: Yogesh Sharma
#>

$siteUrl = Read-Host "Enter SharePoint site URL"
$libraryName = Read-Host "Enter document library name"

Connect-PnPOnline -Url $siteUrl -Interactive

$items = Get-PnPListItem -List $libraryName -PageSize 2000
$hashSet = @{}
$duplicates = @()

foreach ($item in $items) {
    $fileName = $item.FieldValues.FileLeafRef
    $fileUrl = $item.FieldValues.FileRef
    $file = Get-PnPFile -Url $fileUrl -AsByteArray
    $hash = [System.BitConverter]::ToString((New-Object -TypeName System.Security.Cryptography.SHA256Managed).ComputeHash($file))

    if ($hashSet[$hash]) {
        $duplicates += [PSCustomObject]@{ FileName = $fileName; URL = $fileUrl }
    } else {
        $hashSet[$hash] = $true
    }
}

$duplicates | Export-Csv -Path "DuplicateFiles.csv" -NoTypeInformation
Write-Host "Duplicate file report saved to DuplicateFiles.csv"
