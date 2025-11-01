# ==========================================
# Lab 5 – Monitoring + Alerts (Activity Log)
# ==========================================

# 🧱 Step 1: Variables and workspace setup
$rgName     = "MiniLabs-RG"
$location   = "canadacentral"
$agName     = "MiniLabs-AG"
$agShort    = "MiniAG"
$alertName  = "RG-Activity-Write-Alert"
$email      = "your.email@example.com"   # 👈 Replace with your real email

# ------------------------------------------
# Step 2 – Register the Microsoft.Insights provider
# ------------------------------------------
Write-Host "🔧 Registering Microsoft.Insights resource provider..."
Register-AzResourceProvider -ProviderNamespace "Microsoft.Insights" | Out-Null
Write-Host "✅ Provider registration complete."

# ------------------------------------------
# Step 3 – Verify or create the Resource Group
# ------------------------------------------
if (-not (Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $rgName -Location $location | Out-Null
    Write-Host "✅ Resource group '$rgName' created in $location."
}
else {
    Write-Host "ℹ️ Resource group '$rgName' already exists."
}

# ------------------------------------------
# Step 4 – Create the Action Group (Portal fallback supported)
# ------------------------------------------
try {
    New-AzActionGroup `
        -Name $agName `
        -ShortName $agShort `
        -ResourceGroupName $rgName `
        -EmailReceiver @(@{Name="EmailReceiver"; EmailAddress=$email}) | Out-Null
    Write-Host "✅ Action Group '$agName' created with email: $email"
}
catch {
    Write-Host "⚠️ PowerShell Action Group creation failed. Create it manually in the Azure Portal if needed."
}

# ------------------------------------------
# Step 5 – Create the Activity Log Alert Rule
# ------------------------------------------
try {
    # Retrieve Action Group ID for linking
    $ag = Get-AzActionGroup -ResourceGroupName $rgName | Select-Object -First 1
    $scope = "/subscriptions/$((Get-AzContext).Subscription.Id)/resourceGroups/$rgName"
    $description = "Alert when a Write operation occurs in $rgName"

    New-AzActivityLogAlert `
        -Name $alertName `
        -ResourceGroupName $rgName `
        -Scope $scope `
        -Description $description | Out-Null

    Write-Host "✅ Activity Log Alert '$alertName' created (link Action Group manually if needed)."
}
catch {
    Write-Host "⚠️ Could not create Activity Log Alert via PowerShell. Create it manually in the Portal (Monitor → Alerts → +Create → Activity Log)."
}

# ------------------------------------------
# Step 6 – Summary
# ------------------------------------------
Write-Host ""
Write-Host "--------------------------------------------"
Write-Host " LAB 5 SUMMARY"
Write-Host " Resource Group : $rgName"
Write-Host " Action Group   : $agName"
Write-Host " Alert Rule     : $alertName"
Write-Host " Email Receiver : $email"
Write-Host "--------------------------------------------"
Write-Host "✅ Monitoring lab complete – verify alert in Azure Portal → Monitor → Alerts → Alert rules."

