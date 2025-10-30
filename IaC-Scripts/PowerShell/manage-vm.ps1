# =========================================
# File: manage-vm.ps1
# Purpose: Control VM lifecycle (start, stop, restart, delete)
# =========================================

$rg = "DemoLab-RG"
$vm = "LabVM01"

# Stop VM
Stop-AzVM -ResourceGroupName $rg -Name $vm -Force

# Start VM
Start-AzVM -ResourceGroupName $rg -Name $vm

# Restart VM
Restart-AzVM -ResourceGroupName $rg -Name $vm

# Delete VM
# Remove-AzVM -ResourceGroupName $rg -Name $vm -Force

<#
=========================================================
Explanation:
- Each cmdlet performs a specific lifecycle action.
- -Force skips confirmation prompts (use carefully).
- Remove-AzVM permanently deletes the VM.
These commands are often automated via Azure Runbooks.
=========================================================
#>
