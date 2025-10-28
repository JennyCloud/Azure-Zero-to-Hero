# Step 4: Create Azure Virtual Network and Subnets
New-AzVirtualNetwork `
  -Name "Azure-VNet" `
  -ResourceGroupName "HybridLab-RG" `
  -Location "CanadaCentral" `
  -AddressPrefix "10.10.0.0/16" `
  -Subnet @(
     @{Name="VMSubnet"; AddressPrefix="10.10.1.0/24"},
     @{Name="GatewaySubnet"; AddressPrefix="10.10.255.0/27"}
   )

# Step 5: Create VPN Gateway and Public IP
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
