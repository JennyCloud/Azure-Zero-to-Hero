# =========================================
# File: create-vm.ps1
# Purpose: Deploy a Windows Server VM with basic network config
# =========================================

$rg        = "DemoLab-RG"
$location  = "CanadaCentral"
$vmName    = "LabVM01"

# Prompt for credentials
$cred = Get-Credential

# Deploy a simple Windows VM
New-AzVm `
  -ResourceGroupName $rg `
  -Name $vmName `
  -Location $location `
  -Image "Win2022Datacenter" `
  -Size "Standard_B1s" `
  -Credential $cred `
  -PublicIpAddressName "$vmName-pip" `
  -VirtualNetworkName "LabVNet" `
  -SubnetName "WebSubnet" `
  -SecurityGroupName "Web-NSG" `
  -OpenPorts 3389

<#
=========================================================
Explanation:
- Get-Credential securely prompts for admin credentials.
- New-AzVm creates all required dependencies if missing.
- Backticks (`) split long lines for readability.
- -OpenPorts 3389 adds an NSG rule for RDP.
This script spins up a ready-to-use Windows Server in minutes.
=========================================================
#>
