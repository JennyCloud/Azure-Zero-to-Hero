# =========================================
# File: create-network.ps1
# Purpose: Build a VNet, Subnet, Public IP, and NSG with rule
# =========================================

$rg        = "DemoLab-RG"
$location  = "CanadaCentral"

# Create Virtual Network and Subnet
$vnet = New-AzVirtualNetwork -ResourceGroupName $rg -Name "LabVNet" -Location $location -AddressPrefix "10.0.0.0/16"
Add-AzVirtualNetworkSubnetConfig -Name "WebSubnet" -AddressPrefix "10.0.1.0/24" -VirtualNetwork $vnet | Set-AzVirtualNetwork

# Create Public IP
New-AzPublicIpAddress -Name "Lab-PIP" -ResourceGroupName $rg -Location $location -AllocationMethod Static

# Create NSG and allow HTTP
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rg -Location $location -Name "Web-NSG"
$nsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Protocol Tcp -Direction Inbound -Priority 100 `
  -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow | Set-AzNetworkSecurityGroup

<#
=========================================================
Explanation:
- Virtual Network = private Azure network.
- Subnet = segment within the VNet.
- Public IP exposes resources to the internet.
- NSG = firewall controlling inbound/outbound traffic.
This creates the network environment for your VMs or VMSS.
=========================================================
#>
