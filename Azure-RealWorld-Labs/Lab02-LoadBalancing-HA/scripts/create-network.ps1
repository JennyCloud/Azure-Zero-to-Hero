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
