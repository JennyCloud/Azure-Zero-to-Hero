# Step 6: Simulate On-Prem Network and Deploy OnPrem VPN Gateway
# Author: Jenny Wang (@JennyCloud)
# Purpose: Create a second VNet to simulate an on-prem environment and deploy its VPN Gateway

# -------------------------------
# 1. Create the simulated On-Prem VNet
# -------------------------------
New-AzVirtualNetwork `
  -Name "OnPrem-VNet" `
  -ResourceGroupName "HybridLab-RG" `
  -Location "CanadaCentral" `
  -AddressPrefix "192.168.1.0/24" `
  -Subnet @(@{Name="OnPremSubnet"; AddressPrefix="192.168.1.0/25"})

# -------------------------------
# 2. Add GatewaySubnet (must be /27 or larger)
# -------------------------------
$vnetLocal = Get-AzVirtualNetwork -Name "OnPrem-VNet" -ResourceGroupName "HybridLab-RG"

# Replace or add a correct-sized GatewaySubnet
Remove-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnetLocal -ErrorAction SilentlyContinue
Add-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix "192.168.1.224/27" -VirtualNetwork $vnetLocal
$vnetLocal | Set-AzVirtualNetwork

# -------------------------------
# 3. Create a static Public IP for the On-Prem Gateway
# -------------------------------
$pipLocal = New-AzPublicIpAddress `
    -Name "OnPremVPN-PIP" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -Sku "Standard" `
    -AllocationMethod "Static"

# -------------------------------
# 4. Retrieve subnet object and deploy the VPN Gateway
# -------------------------------
$vnetLocal   = Get-AzVirtualNetwork -Name "OnPrem-VNet" -ResourceGroupName "HybridLab-RG"
$subnetLocal = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnetLocal

New-AzVirtualNetworkGateway `
    -Name "OnPremVPN-Gateway" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -IpConfigurations @(
        @{
            Name            = "gwconfig"
            Subnet          = $subnetLocal
            PublicIpAddress = $pipLocal
        }
    ) `
    -GatewayType "Vpn" `
    -VpnType "RouteBased" `
    -GatewaySku "VpnGw1"

# -------------------------------
# Notes:
# - Provisioning takes ~30 minutes.
# - Check progress with:
#   Get-AzVirtualNetworkGateway -Name "OnPremVPN-Gateway" -ResourceGroupName "HybridLab-RG"
# - Expected result: ProvisioningState : Succeeded
# -------------------------------
