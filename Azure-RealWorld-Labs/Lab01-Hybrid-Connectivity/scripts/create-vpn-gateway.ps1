# Step 5: Create VPN Gateway and Public IP
# Author: Jenny Wang (@JennyCloud)
# Purpose: Provision a VPN Gateway with a Static Public IP for Hybrid Connectivity Lab

# Create a Standard, Static Public IP (required for VPN Gateway)
$pip = New-AzPublicIpAddress `
    -Name "AzureVPN-PIP" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -Sku "Standard" `
    -AllocationMethod "Static"

# Retrieve the virtual network and its GatewaySubnet
$vnet   = Get-AzVirtualNetwork -Name "Azure-VNet" -ResourceGroupName "HybridLab-RG"
$subnet = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet

# Create the VPN Gateway
New-AzVirtualNetworkGateway `
    -Name "AzureVPN-Gateway" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -IpConfigurations @(
        @{
            Name            = "gwconfig"
            Subnet          = $subnet
            PublicIpAddress = $pip
        }
    ) `
    -GatewayType "Vpn" `
    -VpnType "RouteBased" `
    -GatewaySku "VpnGw1"
