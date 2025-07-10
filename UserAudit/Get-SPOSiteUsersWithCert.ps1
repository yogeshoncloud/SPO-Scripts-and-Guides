<#
.SYNOPSIS
    Retrieves user details from all SharePoint Online site collections using certificate-based authentication.

.DESCRIPTION
    This script connects to SharePoint Online using a registered Entra ID App and certificate, then retrieves user information including:
    - Site Title
    - Site URL
    - User Login Name
    - User Email
    - External User Status

.NOTES
    Author: Yogesh Sharma
    Date: 2025-07-10
#>

# ==== Configuration ====
$tenant = "yourtenant.onmicrosoft.com"
$clientId = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$certificatePath = "C:\Path\To\YourCert.pfx"
$certificatePassword = ConvertTo-SecureString "YourPfxPassword" -AsPlainText -Force
$adminUrl = "https://yourtenant-admin.sharepoint.com"
$outputPath = "SPO_User_Report.csv"

# ==== Connect to SPO ====
Connect-PnPOnline -Url $adminUrl `
    -ClientId $clientId `
    -Tenant $tenant `
    -CertificatePath $certificatePath `
    -CertificatePassword $certificatePassword

# ==== Get Sites ====
$sites = Get-PnPTenantSite -IncludeOneDriveSites:$false -Filter "Template -ne 'APP'" -IncludeDetail

# ==== Collect Data ====
$result = @()
foreach ($site in $sites) {
    try {
        Connect-PnPOnline -Url $site.Url `
            -ClientId $clientId `
            -Tenant $tenant `
            -CertificatePath $certificatePath `
            -CertificatePassword $certificatePassword

        $web = Get-PnPWeb
        $users = Get-PnPUser | Where-Object { $_.PrincipalType -eq 'User' }

        foreach ($user in $users) {
            $result += [PSCustomObject]@{
                SiteTitle   = $web.Title
                SiteUrl     = $site.Url
                LoginName   = $user.LoginName
                Email       = $user.Email
                IsExternal  = $user.LoginName -like "*#ext#*"
            }
        }
    }
    catch {
        Write-Warning "Failed to access $($site.Url): $_"
    }
}

# ==== Export ====
$result | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8
Write-Host "Export complete: $outputPath"
