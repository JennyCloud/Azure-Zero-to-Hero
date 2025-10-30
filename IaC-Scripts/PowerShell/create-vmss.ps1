<#
.SYNOPSIS
Deploys a Virtual Machine Scale Set with automatic scaling and load balancing.
#>

param(
  [string]$rg = "VMSSLab-RG",
  [string]$location = "CanadaCentral",
  [int]$instanceCount = 2
)

Write-Host "Creating resource group..."
New-AzResourceGroup -Name $rg -Location $location

Write-Host "Deploying VM Scale Set..."
New-AzVmss `
  -ResourceGroupName $rg `
  -Location $location `
  -VMScaleSetName "WebApp-VMSS" `
  -VirtualNetworkName "VMSS-VNet" `
  -SubnetName "WebSubnet" `
  -PublicIpAddressName "WebApp-PIP" `
  -LoadBalancerName "WebApp-LB" `
  -BackendPort 80 `
  -InstanceCount $instanceCount `
  -UpgradePolicyMode "Automatic" `
  -ImageName "Win2022Datacenter" `
  -Credential (Get-Credential)

Write-Host "VMSS deployed successfully!"
