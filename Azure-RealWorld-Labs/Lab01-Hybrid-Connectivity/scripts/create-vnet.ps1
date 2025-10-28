# Step 4: Create Azure Virtual Network and Subnets for Lab01
New-AzVirtualNetwork `
  -Name "Azure-VNet" `
  -ResourceGroupName "HybridLab-RG" `
  -Location "CanadaCentral" `
  -AddressPrefix "10.10.0.0/16" `
  -Subnet @(
     @{Name="VMSubnet"; AddressPrefix="10.10.1.0/24"},
     @{Name="GatewaySubnet"; AddressPrefix="10.10.255.0/27"}
   )
