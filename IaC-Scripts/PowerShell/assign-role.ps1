# =========================================
# File: assign-role.ps1
# Purpose: Assign RBAC role to a user for a specific resource
# =========================================

$rg      = "DemoLab-RG"
$user    = "user@contoso.com"
$storage = "jennyazlabstorage01"

New-AzRoleAssignment `
  -ObjectId ( (Get-AzADUser -UserPrincipalName $user).Id ) `
  -RoleDefinitionName "Storage Blob Data Contributor" `
  -Scope (Get-AzStorageAccount -ResourceGroupName $rg -Name $storage).Id

<#
=========================================================
Explanation:
- RBAC (Role-Based Access Control) defines permissions in Azure.
- This assigns "Storage Blob Data Contributor" to a user.
- Scope limits where the permission applies (here, one Storage Account).
Use for controlled, least-privilege access.
=========================================================
#>
