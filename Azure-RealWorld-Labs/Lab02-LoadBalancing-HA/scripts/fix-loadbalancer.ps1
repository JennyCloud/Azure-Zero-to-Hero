# Purpose: Replace HTTP probe with TCP probe and refresh load-balancing rule

# Retrieve the existing Load Balancer
$lb = Get-AzLoadBalancer -Name "Web-LB" -ResourceGroupName "LoadBalancer-Lab-RG"

# Remove the existing HTTP probe (if present)
$lb.LoadBalancerProbes = $lb.LoadBalancerProbes | Where-Object { $_.Name -ne "HTTP-Probe" }

# Create a new TCP probe for port 80
$tcpProbe = New-AzLoadBalancerProbeConfig `
  -Name "TCP-Probe" `
  -Protocol Tcp `
  -Port 80 `
  -IntervalInSeconds 15 `
  -ProbeCount 2

# Replace the existing load-balancing rule with one that uses the TCP probe
$rule = New-AzLoadBalancerRuleConfig `
  -Name "HTTP-Rule" `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -IdleTimeoutInMinutes 5 `
  -FrontendIpConfiguration $lb.FrontendIpConfigurations[0] `
  -BackendAddressPool $lb.BackendAddressPools[0] `
  -Probe $tcpProbe

# Apply the new configuration
$lb.LoadBalancingRules.Clear()
$lb.LoadBalancingRules.Add($rule)
$lb.LoadBalancerProbes.Clear()
$lb.LoadBalancerProbes.Add($tcpProbe)

# Update the Load Balancer in Azure
Set-AzLoadBalancer -LoadBalancer $lb

# Output the result for verification
Get-AzLoadBalancer -Name "Web-LB" -ResourceGroupName "LoadBalancer-Lab-RG" |
  Select-Object Name, ProvisioningState, Sku
