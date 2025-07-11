<#
.SYNOPSIS
Lists all external users with access to the SharePoint Online environment.

.DESCRIPTION
Uses Microsoft Graph to fetch all guest users and their directory details.

.NOTES
Author: Yogesh Sharma
#>

Connect-MgGraph -Scopes "User.Read.All"

$guests = Get-MgUser -Filter "userType eq 'Guest'" -All

$guests | Select-Object DisplayName, UserPrincipalName, AccountEnabled, CreatedDateTime |
Export-Csv -Path "ExternalUsersReport.csv" -NoTypeInformation

Write-Host "External users report saved as ExternalUsersReport.csv"
