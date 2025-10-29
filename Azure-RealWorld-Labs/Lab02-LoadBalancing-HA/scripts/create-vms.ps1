# Step 5: Create Web VMs (via PowerShell or Portal)
# Note: Portal was used to create WebVM1 and WebVM2 due to Trusted Launch limitations in free-tier subscription.

# Reference network interfaces
$nic1 = Get-AzNetworkInterface -Name "WebVM1-NIC" -ResourceGroupName "LoadBalancer-Lab-RG"
$nic2 = Get-AzNetworkInterface -Name "WebVM2-NIC" -ResourceGroupName "LoadBalancer-Lab-RG"

# Verify NICs are associated with the correct subnet and NSG
$nic1 | Select Name, IpConfigurations
$nic2 | Select Name, IpConfigurations
