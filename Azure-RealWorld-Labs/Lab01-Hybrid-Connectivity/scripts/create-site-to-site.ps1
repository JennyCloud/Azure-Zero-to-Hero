# Step 6.3: Create Site-to-Site (VNet-to-VNet) VPN Connections
# Purpose: Establish encrypted tunnels between AzureVPN-Gateway and OnPremVPN-Gateway


# -------------------------------------------------
# 1. Retrieve both gateways
# -------------------------------------------------
$azureGw  = Get-AzVirtualNetworkGateway -Name "AzureVPN-Gateway"  -ResourceGroupName "HybridLab-RG"
$onpremGw = Get-AzVirtualNetworkGateway -Name "OnPremVPN-Gateway" -ResourceGroupName "HybridLab-RG"

# -------------------------------------------------
# 2. Create the primary connection (Azure → On-Prem)
# -------------------------------------------------
New-AzVirtualNetworkGatewayConnection `
    -Name "AzureToOnPrem-Connection" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -VirtualNetworkGateway1 $azureGw `
    -VirtualNetworkGateway2 $onpremGw `
    -ConnectionType "Vnet2Vnet" `
    -SharedKey "Lab123!SharedKey"

# -------------------------------------------------
# 3. Create the reverse connection (On-Prem → Azure)
# -------------------------------------------------
New-AzVirtualNetworkGatewayConnection `
    -Name "OnPremToAzure-Connection" `
    -ResourceGroupName "HybridLab-RG" `
    -Location "CanadaCentral" `
    -VirtualNetworkGateway1 $onpremGw `
    -VirtualNetworkGateway2 $azureGw `
    -ConnectionType "Vnet2Vnet" `
    -SharedKey "Lab123!SharedKey"

# -------------------------------------------------
# 4. (Optional) Re-sync shared keys if needed
# -------------------------------------------------
Set-AzVirtualNetworkGatewayConnectionSharedKey `
  -Name "AzureToOnPrem-Connection" `
  -ResourceGroupName "HybridLab-RG" `
  -Value "Lab123!SharedKey"

Set-AzVirtualNetworkGatewayConnectionSharedKey `
  -Name "OnPremToAzure-Connection" `
  -ResourceGroupName "HybridLab-RG" `
  -Value "Lab123!SharedKey"

# -------------------------------------------------
# 5. Verify both connections
# -------------------------------------------------
Get-AzVirtualNetworkGatewayConnection -ResourceGroupName "HybridLab-RG" |
  Select-Object Name, ConnectionType, ConnectionStatus, EgressBytesTransferred

# Expected: ConnectionStatus = Connected after a few minutes
# -------------------------------------------------

