<#
.SYNOPSIS
Creates a simple Windows VM in Azure.

.DESCRIPTION
This script creates a Resource Group, Virtual Network, Subnet, Public IP, and a Windows VM.
Tested in Azure Cloud Shell (PowerShell environment).
#>

param(
  [string]$rg = "PSLab-RG",
  [string]$location = "CanadaCentral",
  [string]$vmName = "LabVM01"
)

Write-Host "Creating resource group..."
New-AzResourceGroup -Name $rg -Location $location

Write-Host "Deploying virtual machine..."
New-AzVm `
  -ResourceGroupName $rg `
  -Name $vmName `
  -Location $location `
  -Image "Win2022Datacenter" `
  -PublicIpAddressName "$vmName-pip" `
  -OpenPorts 3389

Write-Host "VM deployed successfully!"
