<#
.SYNOPSIS
Performs a basic health check of SharePoint Online sites.

.DESCRIPTION
This script pulls last modified date, storage usage, and owner for each SPO site.

.NOTES
Author: Yogesh Sharma
#>

Connect-PnPOnline -Url "https://yourtenant-admin.sharepoint.com" -Interactive

$sites = Get-PnPTenantSite

$report = $sites | Select-Object Url, Title, StorageUsageCurrent, LastContentModifiedDate, Owner

$report | Export-Csv -Path "DailyHealthCheck.csv" -NoTypeInformation

Write-Host "Health check report saved as DailyHealthCheck.csv"
