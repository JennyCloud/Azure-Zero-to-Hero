# ================================
# Runbook: StartStopVMs
# Purpose: Start/Stop all VMs in a target RG on schedule
# Runtime: PowerShell 5.1 (Az Modules in Automation Account)
# ================================

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Start", "Stop")]
    [string]$Action,

    # Optional: target RG and tag to filter which VMs to control
    [string]$ResourceGroupName = "AutomationLab-RG",
    [string]$RequiredTagName = "",
    [string]$RequiredTagValue = ""
)

# Use the Automation Account's system-assigned managed identity
Connect-AzAccount -Identity | Out-Null

# Get VMs
$vms = Get-AzVM -ResourceGroupName $ResourceGroupName -Status

# Optional tag filter
if ($RequiredTagName -and $RequiredTagValue) {
    $vms = $vms | Where-Object {
        $_.Tags.ContainsKey($RequiredTagName) -and $_.Tags[$RequiredTagName] -eq $RequiredTagValue
    }
}

if (-not $vms) {
    Write-Output "No matching VMs found in RG '$ResourceGroupName'. Nothing to do."
    return
}

foreach ($vm in $vms) {
    $name = $vm.Name
    $state = ($vm.Statuses | Where-Object Code -like "PowerState/*").DisplayStatus

    switch ($Action) {
        "Stop" {
            if ($state -eq "VM deallocated" -or $state -eq "VM stopped") {
                Write-Output "Skip: $name is already $state."
            } else {
                Write-Output "Stopping VM: $name"
                Stop-AzVM -Name $name -ResourceGroupName $ResourceGroupName -Force -ErrorAction Stop
            }
        }
        "Start" {
            if ($state -eq "VM running") {
                Write-Output "Skip: $name is already running."
            } else {
                Write-Output "Starting VM: $name"
                Start-AzVM -Name $name -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            }
        }
    }
}
Write-Output "Action '$Action' complete."
