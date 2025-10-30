# =========================================
# File: create-vmss-with-loadbalancer.ps1
# Purpose: Deploy a Virtual Machine Scale Set with a Load Balancer
# =========================================

# ---------- Variables ----------
$rg        = "ComputeLab-RG"
$location  = "CanadaCentral"
$vmssName  = "WebApp-VMSS"
$vnetName  = "ComputeVNet"
$subnet    = "WebSubnet"
$lbName    = "WebApp-LB"
$pipName   = "WebApp-PIP"
$backend   = "LB-BackendPool"
$probeName = "TCP-Probe"
$ruleName  = "HTTP-Rule"

# ---------- Resource Group ----------
# Create or reuse a resource group
New-AzResourceGroup -Name $rg -Location $location

# ---------- Networking ----------
# 1. Create a virtual network with one subnet
$vnet = New-AzVirtualNetwork -ResourceGroupName $rg -Name $vnetName -Location $location -AddressPrefix "10.0.0.0/16"
Add-AzVirtualNetworkSubnetConfig -Name $subnet -AddressPrefix "10.0.1.0/24" -VirtualNetwork $vnet | Set-AzVirtualNetwork

# 2. Create a public IP for the Load Balancer
$pip = New-AzPublicIpAddress -ResourceGroupName $rg -Location $location -AllocationMethod Static -Name $pipName

# 3. Create the Load Balancer
$frontend = New-AzLoadBalancerFrontendIpConfig -Name "LB-Frontend" -PublicIpAddress $pip
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name $backend
$probe = New-AzLoadBalancerProbeConfig -Name $probeName -Protocol Tcp -Port 80 -IntervalInSeconds 5 -ProbeCount 2
$rule = New-AzLoadBalancerRuleConfig -Name $ruleName -Protocol Tcp -FrontendPort 80 -BackendPort 80 -Probe $probe -FrontendIpConfiguration $frontend -BackendAddressPool $backendPool

New-AzLoadBalancer -ResourceGroupName $rg -Name $lbName -Location $location `
  -FrontendIpConfiguration $frontend -BackendAddressPool $backendPool `
  -Probe $probe -LoadBalancingRule $rule

# ---------- Credentials ----------
# Prompt once for local admin credentials
$cred = Get-Credential

# ---------- VM Scale Set ----------
New-AzVmss `
  -ResourceGroupName $rg `
  -Location $location `
  -VMScaleSetName $vmssName `
  -VirtualNetworkName $vnetName `
  -SubnetName $subnet `
  -PublicIpAddressName $pipName `
  -LoadBalancerName $lbName `
  -BackendPort 80 `
  -InstanceCount 2 `
  -UpgradePolicyMode "Automatic" `
  -ImageName "Win2022Datacenter" `
  -Credential $cred

# ---------- Verification ----------
# List all instances and public IP
Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName
Get-AzPublicIpAddress -ResourceGroupName $rg -Name $pipName | Select-Object IpAddress

<#
=========================================================
Explanation:

1. VARIABLES
   Define reusable names and locations to keep the script tidy.

2. RESOURCE GROUP
   New-AzResourceGroup ensures a container exists for all resources.

3. NETWORKING
   - New-AzVirtualNetwork / Add-AzVirtualNetworkSubnetConfig create an internal network (10.0.0.0/16) and subnet (10.0.1.0/24).
   - New-AzPublicIpAddress provisions a static public endpoint.
   - Load Balancer:
       * Frontend: Public IP interface that receives traffic.
       * BackendPool: Target VM instances.
       * Probe: Health check (TCP port 80) used for load-balancing decisions.
       * Rule: Defines how frontend traffic maps to backend ports.

4. CREDENTIALS
   Get-Credential stores secure admin credentials for all VM instances.

5. VM SCALE SET
   New-AzVmss automatically:
       - Deploys identical Windows Server VMs behind the load balancer.
       - Registers each instance in the backend pool.
       - Enables automatic upgrades and scaling.
       - Uses the supplied credential for all VMs.

6. VERIFICATION
   Get-AzVmss confirms the deployment.
   Get-AzPublicIpAddress shows the public IP—open it in a browser to test IIS once installed.

RESULT:
A highly available, automatically scalable web tier with two identical VMs
served through a single load-balanced public IP.
=========================================================
#>
