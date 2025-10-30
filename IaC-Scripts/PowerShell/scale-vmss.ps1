# =========================================
# File: scale-vmss.ps1
# Purpose: Manage, scale, and maintain an existing Azure VM Scale Set
# =========================================

# ---------- Variables ----------
$rg       = "ComputeLab-RG"
$vmssName = "WebApp-VMSS"

# ---------- Show Current Info ----------
Write-Host "Getting current VMSS details..."
Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName | `
    Select-Object Name, Location, Sku, ProvisioningState, UpgradePolicyMode

# ---------- Scale Out ----------
# Increase instance count to 3
Write-Host "Scaling out VMSS to 3 instances..."
Update-AzVmss -ResourceGroupName $rg -Name $vmssName -SkuCapacity 3

# Verify
(Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName).Sku.Capacity

# ---------- Scale In ----------
# Reduce instance count to 1 (optional demo)
# Write-Host "Scaling in VMSS to 1 instance..."
# Update-AzVmss -ResourceGroupName $rg -Name $vmssName -SkuCapacity 1

# ---------- Restart Instances ----------
# Restart all VMs in the scale set
Write-Host "Restarting all VMSS instances..."
Restart-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName

# ---------- Update Configuration ----------
# Example: Change upgrade policy to Manual
# Write-Host "Changing upgrade policy to Manual..."
# $vmss = Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName
# $vmss.UpgradePolicy.Mode = "Manual"
# Update-AzVmss -ResourceGroupName $rg -Name $vmssName -VirtualMachineScaleSet $vmss

# ---------- Delete VMSS ----------
# Optional: clean up the scale set
# Remove-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName -Force

<#
=========================================================
Explanation:

1. VARIABLES
   Define the resource group and scale set name to target the correct environment.

2. SHOW CURRENT INFO
   Get-AzVmss lists current configuration—useful before making changes.

3. SCALE OUT / SCALE IN
   - Update-AzVmss -SkuCapacity changes the number of instances.
   - Azure automatically provisions or removes identical VMs.
   - Scaling out improves capacity; scaling in reduces cost.

4. RESTART INSTANCES
   Restart-AzVmss refreshes all VMs at once—handy after updates or patching.

5. UPDATE CONFIGURATION
   The UpgradePolicyMode can be:
     - Automatic (default): Azure rolls out updates automatically.
     - Manual: You trigger upgrades yourself, giving tighter control.

6. DELETE VMSS
   Remove-AzVmss deletes the scale set but leaves other resources intact.
   Always double-check before using -Force.

RESULT:
This script gives you full control of your VM Scale Set lifecycle—
inspect, expand, shrink, or restart your cluster with just a few lines.
=========================================================
#>
