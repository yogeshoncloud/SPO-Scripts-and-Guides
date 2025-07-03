<#
.SYNOPSIS
Generates a storage usage report for all SharePoint Online sites.

.DESCRIPTION
This script lists all site collections and their current storage usage using PnP PowerShell.

.NOTES
Author: Yogesh Sharma
#>

Connect-PnPOnline -Url "https://yourtenant-admin.sharepoint.com" -Interactive

$sites = Get-PnPTenantSite

$sites | Select-Object Url, Title, StorageUsageCurrent, StorageQuota, LastContentModifiedDate |
Export-Csv -Path "SPOSitesStorageReport.csv" -NoTypeInformation

Write-Host "Storage report saved as SPOSitesStorageReport.csv"
