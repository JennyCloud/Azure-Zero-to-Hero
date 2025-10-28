# Step 7: Test VPN Connectivity Between Azure and On-Prem VNets
# Purpose: Verify site-to-site VPN tunnel with ICMP tests and traffic monitoring

# ----------------------------------------------------------
# 1. Retrieve both test VMs' private IPs
# ----------------------------------------------------------
$azureVM = Get-AzNetworkInterface -ResourceGroupName "HybridLab-RG" | Where-Object { $_.Name -like "*AzureTestVMNic*" }
$onpremVM = Get-AzNetworkInterface -ResourceGroupName "HybridLab-RG" | Where-Object { $_.Name -like "*OnPremTestVMNic*" }

Write-Host "AzureTestVM Private IP:" $azureVM.IpConfigurations.PrivateIpAddress
Write-Host "OnPremTestVM Private IP:" $onpremVM.IpConfigurations.PrivateIpAddress

# ----------------------------------------------------------
# 2. Verify VPN Connection Status
# ----------------------------------------------------------
Get-AzVirtualNetworkGatewayConnection -ResourceGroupName "HybridLab-RG" |
  Select-Object Name, ConnectionType, ConnectionStatus, EgressBytesTransferred

# ----------------------------------------------------------
# 3. Instructions for manual ping tests
# ----------------------------------------------------------
Write-Host "`n--- Manual Steps ---"
Write-Host "1. Connect to OnPremTestVM via Azure Bastion."
Write-Host "2. Run:  netsh advfirewall firewall add rule name='Allow ICMPv4' protocol=icmpv4:8,any dir=in action=allow"
Write-Host "3. From OnPremTestVM, ping AzureTestVM's private IP."
Write-Host "4. Expect 'Reply from <IP>' if tunnel is active."
Write-Host "5. Return here and re-run Step 2 to confirm EgressBytesTransferred > 0."
Write-Host "------------------------------------------"

# ----------------------------------------------------------
# End of Script
# ----------------------------------------------------------
