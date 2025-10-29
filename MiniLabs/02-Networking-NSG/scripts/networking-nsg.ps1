# =============================
# Mini Lab 2 — Networking + NSG
# =============================

# 1. Variables
$rg        = "LabLadder-RG"
$location  = "canadacentral"
$vnetName  = "LabVNet"
$subnetName = "WebSubnet"
$nsgName   = "WebSubnet-NSG"

# 2. Create the Virtual Network and Subnet
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.10.1.0/24"
$vnet = New-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rg `
  -Location $location `
  -AddressPrefix "10.10.0.0/16" `
  -Subnet $subnetConfig

# 3. Create an empty NSG
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $rg `
  -Location $location `
  -Name $nsgName

# 4. Create an inbound rule for port 80 (HTTP)
$rule = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-HTTP" `
  -Description "Allow inbound HTTP traffic" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix "*" `
  -SourcePortRange "*" `
  -DestinationAddressPrefix "*" `
  -DestinationPortRange 80

# 5. Add the rule to the NSG and update Azure
$nsg.SecurityRules.Add($rule)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg

# 6. Associate the NSG with the subnet
Set-AzVirtualNetworkSubnetConfig `
  -VirtualNetwork $vnet `
  -Name $subnetName `
  -AddressPrefix "10.10.1.0/24" `
  -NetworkSecurityGroup $nsg | Out-Null
$vnet | Set-AzVirtualNetwork
