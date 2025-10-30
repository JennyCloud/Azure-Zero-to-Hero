<#
.SYNOPSIS
Creates a virtual network and subnet.
#>

param(
  [string]$rg = "NetworkLab-RG",
  [string]$location = "CanadaCentral"
)

Write-Host "Creating resource group..."
New-AzResourceGroup -Name $rg -Location $location

Write-Host "Creating virtual network..."
$vnet = New-AzVirtualNetwork -Name "LabVNet" -ResourceGroupName $rg -Location $location -AddressPrefix "10.0.0.0/16"
Add-AzVirtualNetworkSubnetConfig -Name "WebSubnet" -AddressPrefix "10.0.1.0/24" -VirtualNetwork $vnet | Set-AzVirtualNetwork

Write-Host "VNet created successfully!"
