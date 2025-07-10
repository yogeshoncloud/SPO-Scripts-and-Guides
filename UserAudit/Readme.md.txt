# SharePoint Online User Audit using PnP PowerShell with Certificate Authentication

## 📌 Script Name
**Get-SPOSiteUsersWithCert.ps1**

## 👨‍💻 Author
**Yogesh Sharma**

## 🗓️ Last Updated
July 10, 2025

---

## 📄 Description

This script uses certificate-based authentication to securely connect to SharePoint Online and retrieves user information across all site collections. It’s designed for IT admins and governance professionals to audit user access and identify external collaborators.

---

## 🔍 What This Script Does

- Connects to SharePoint Online using a registered Entra ID App and certificate (.pfx)
- Retrieves details from each site:
  - Site Title
  - Site URL
  - User Login Name
  - Email Address
  - External User Status

- Exports the results into a `.csv` file for further review or reporting.

---

## ⚙️ Prerequisites

- [PnP PowerShell](https://pnp.github.io/powershell/)
- Registered Entra ID App with:
  - `Sites.Read.All`
  - `Sites.FullControl.All`
- PFX Certificate with private key
- Global Admin or SharePoint Admin role

---

## 🧪 Usage

1. Update the variables in the script:
   - `$tenant`
   - `$clientId`
   - `$certificatePath`
   - `$certificatePassword`
   - `$adminUrl`

2. Run the script in PowerShell:

```powershell
.\Get-SPOSiteUsersWithCert.ps1
