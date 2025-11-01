# ==========================================
# Lab 4 – Microsoft Entra ID User + Role
# ==========================================

# 🧱 Step 1: Create or verify the resource group
$rgName = "MiniLabs-RG"
$location = "canadacentral"

if (-not (Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $rgName -Location $location | Out-Null
    Write-Host "✅ Resource group '$rgName' created in $location."
} else {
    Write-Host "ℹ️ Resource group '$rgName' already exists."
}

# 👤 Step 2: Create an Entra ID (Azure AD) user
$domain = (Get-AzTenant).Domains[0]
$upn = "labuser1@$domain"
$password = ConvertTo-SecureString "P@ssword1234" -AsPlainText -Force

if (-not (Get-AzADUser -DisplayName "LabUser1" -ErrorAction SilentlyContinue)) {
    New-AzADUser `
        -DisplayName "LabUser1" `
        -UserPrincipalName $upn `
        -Password $password `
        -MailNickname "labuser1" `
        -ForceChangePasswordNextLogin:$true | Out-Null
    Write-Host "✅ User 'LabUser1' created with UPN: $upn"
} else {
    Write-Host "ℹ️ User 'LabUser1' already exists."
}

# 🔐 Step 3: Assign Reader role to the user at RG scope
$user = Get-AzADUser -DisplayName "LabUser1"
$role = Get-AzRoleDefinition -Name "Reader"
$subId = (Get-AzContext).Subscription.Id
$scope = "/subscriptions/$subId/resourceGroups/$rgName"

try {
    New-AzRoleAssignment -ObjectId $user.Id -RoleDefinitionId $role.Id -Scope $scope | Out-Null
    Write-Host "✅ Reader role assigned to 'LabUser1' for resource group '$rgName'."
} catch {
    Write-Host "⚠️ Role assignment failed. Check if the user and resource group exist and retry."
}

# 🧹 Step 4: Summary
Write-Host "--------------------------------------------"
Write-Host " Lab Completed Successfully!"
Write-Host " User: $upn"
Write-Host " Role: Reader"
Write-Host " Scope: $scope"
Write-Host "--------------------------------------------"
