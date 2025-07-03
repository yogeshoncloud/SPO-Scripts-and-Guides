<#
.SYNOPSIS
Audits site collections before migration.

.DESCRIPTION
This script gathers metadata like size, template, number of files, and permissions.

.NOTES
Author: Yogesh Sharma
#>

Connect-PnPOnline -Url "https://yourtenant-admin.sharepoint.com" -Interactive

$sites = Get-PnPTenantSite

$report = foreach ($site in $sites) {
    Get-PnPStorageEntity -Web $site.Url
    [PSCustomObject]@{
        SiteUrl   = $site.Url
        Title     = $site.Title
        StorageMB = $site.StorageUsageCurrent
        Template  = $site.Template
    }
}

$report | Export-Csv -Path "PreMigrationAudit.csv" -NoTypeInformation
Write-Host "Audit complete. Output saved to PreMigrationAudit.csv"
