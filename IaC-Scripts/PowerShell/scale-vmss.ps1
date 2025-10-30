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
   Get-AzVmss lists the current configuration—useful before making changes.

3. SCALE OUT / SCALE IN
   - Update-AzVmss -SkuCapacity changes the number of VM instances.
   - Azure automatically provisions or removes identical VMs.
   - Scaling out increases performance; scaling in saves cost.

4. RESTART INSTANCES
   Restart-AzVmss restarts all VMs at once, often after patching or configuration changes.

5. UPDATE CONFIGURATION
   The UpgradePolicyMode can be:
     - Automatic: Azure updates instances automatically (default).
     - Manual: You trigger updates manually, giving tighter control.

6. DELETE VMSS
   Remove-AzVmss deletes the scale set but leaves networking intact.
   The -Force flag skips confirmation prompts (use carefully).

---------------------------------------------------------
About Write-Host:

Write-Host prints text directly to the PowerShell console.  
It’s used for **user-friendly feedback** — progress messages, step indicators,
and simple visual cues while the script runs.

Example:
    Write-Host "Creating Resource Group..."
    New-AzResourceGroup -Name "DemoLab-RG" -Location "CanadaCentral"
    Write-Host "Resource Group created successfully!"

This shows progress messages in real time but does not output data to the
pipeline. Use Write-Output instead if you need data to be captured or piped
to another command.

You can also format output:
    Write-Host "Deploying..." -ForegroundColor Cyan
    Write-Host "Success!" -ForegroundColor Green

In summary:
  - Write-Host = talk to humans (screen)
  - Write-Output = talk to scripts (data)
---------------------------------------------------------

RESULT:
This script gives full lifecycle control of a VM Scale Set—
inspect, expand, shrink, restart, or update with clear, color-coded feedback.
=========================================================
#>
