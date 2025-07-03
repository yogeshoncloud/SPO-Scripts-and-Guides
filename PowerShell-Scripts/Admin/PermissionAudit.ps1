<#
.SYNOPSIS
Audits SharePoint Online site permissions using PnP PowerShell.

.DESCRIPTION
This script retrieves unique permissions from all lists/libraries within a specified site and exports the results to a CSV file.

.NOTES
Author: Yogesh Sharma
#>

# Connect to SharePoint Online site
$siteUrl = Read-Host "Enter the SharePoint site URL"
Connect-PnPOnline -Url $siteUrl -Interactive

# Get all lists with unique permissions
$lists = Get-PnPList | Where-Object { $_.HasUniqueRoleAssignments -eq $true }

$report = @()

foreach ($list in $lists) {
    $roles = Get-PnPListItemPermission -List $list.Title
    foreach ($role in $roles) {
        $report += [PSCustomObject]@{
            ListTitle = $list.Title
            Principal = $role.PrincipalName
            Role      = $role.RoleDefinitionBindings -join ", "
        }
    }
}

# Export the results
$report | Export-Csv -Path "PermissionsReport.csv" -NoTypeInformation
Write-Host "Report saved as PermissionsReport.csv"
