# Step 7: Create a public Load Balancer for WebVM1 and WebVM2

$publicIp = New-AzPublicIpAddress `
  -ResourceGroupName "LoadBalancer-Lab-RG" `
  -Name "LB-PublicIP" `
  -Location "CanadaCentral" `
  -Sku Standard `
  -AllocationMethod Static

$frontend = New-AzLoadBalancerFrontendIpConfig `
  -Name "LB-Frontend" `
  -PublicIpAddress $publicIp

$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "LB-Backend"

$probe = New-AzLoadBalancerProbeConfig `
  -Name "HTTP-Probe" `
  -Protocol Http `
  -Port 80 `
  -RequestPath "/" `
  -IntervalInSeconds 15 `
  -ProbeCount 2

$rule = New-AzLoadBalancerRuleConfig `
  -Name "HTTP-Rule" `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -IdleTimeoutInMinutes 5 `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backendPool `
  -Probe $probe

New-AzLoadBalancer `
  -ResourceGroupName "LoadBalancer-Lab-RG" `
  -Name "Web-LB" `
  -Location "CanadaCentral" `
  -Sku Standard `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backendPool `
  -Probe $probe `
  -LoadBalancingRule $rule
