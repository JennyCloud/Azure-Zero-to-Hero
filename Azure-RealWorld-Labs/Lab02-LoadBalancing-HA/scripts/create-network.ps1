# Lab 02 – Load Balancing & High Availability
# Author: Jenny Wang (@JennyCloud)
# Purpose: Create VNet and NSG for Load Balancer lab

# Step 2: Create VNet and Subnet
New-AzVirtualNetwork `
  -Name "LB-Lab-VNet" `
  -ResourceGroupName "LoadBalancer-Lab-RG" `
  -Location "CanadaCentral" `
  -AddressPrefix "10.20.0.0/16" `
  -Subnet @(
      New-AzVirtualNetworkSubnetConfig `
        -Name "WebSubnet" `
        -AddressPrefix "10.20.1.0/24"
  )

# Step 3: Create NSG with inbound HTTP and RDP rules
$ruleHTTP = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-HTTP" -Description "Allow inbound HTTP traffic" `
  -Protocol "Tcp" -Direction "Inbound" -Priority 100 `
  -SourceAddressPrefix "*" -SourcePortRange "*" `
  -DestinationAddressPrefix "*" -DestinationPortRange 80 `
  -Access "Allow"

$ruleRDP = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-RDP" -Description "Allow RDP for remote access" `
  -Protocol "Tcp" -Direction "Inbound" -Priority 200 `
  -SourceAddressPrefix "*" -SourcePortRange "*" `
  -DestinationAddressPrefix "*" -DestinationPortRange 3389 `
  -Access "Allow"

New-AzNetworkSecurityGroup `
  -ResourceGroupName "LoadBalancer-Lab-RG" `
  -Location "CanadaCentral" `
  -Name "Web-NSG" `
  -SecurityRules @($ruleHTTP, $ruleRDP)
