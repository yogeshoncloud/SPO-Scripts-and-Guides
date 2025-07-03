<#
.SYNOPSIS
Creates a new SharePoint Online communication site with user-specified settings.

.DESCRIPTION
Uses PnP PowerShell to provision a modern communication site and assigns a site owner.

.NOTES
Author: Yogesh Sharma
#>

$siteTitle = Read-Host "Enter site title"
$siteUrl = Read-Host "Enter site URL (without https://)"
$owner = Read-Host "Enter site owner email"

Connect-PnPOnline -Url "https://yourtenant-admin.sharepoint.com" -Interactive

New-PnPSite -Type CommunicationSite -Title $siteTitle -Url "https://$siteUrl" -Owner $owner

Write-Host "Site $siteTitle created successfully at https://$siteUrl"
