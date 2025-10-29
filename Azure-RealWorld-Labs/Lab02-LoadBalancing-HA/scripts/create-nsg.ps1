# Step 3: Create NSG and inbound rules

$ruleHTTP = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-HTTP" `
  -Description "Allow inbound HTTP traffic" `
  -Protocol "Tcp" -Direction "Inbound" -Priority 100 `
  -SourceAddressPrefix "*" -SourcePortRange "*" `
  -DestinationAddressPrefix "*" -DestinationPortRange 80 `
  -Access "Allow"

$ruleRDP = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-RDP" `
  -Description "Allow RDP access" `
  -Protocol "Tcp" -Direction "Inbound" -Priority 200 `
  -SourceAddressPrefix "*" -SourcePortRange "*" `
  -DestinationAddressPrefix "*" -DestinationPortRange 3389 `
  -Access "Allow"

New-AzNetworkSecurityGroup `
  -ResourceGroupName "LoadBalancer-Lab-RG" `
  -Location "CanadaCentral" `
  -Name "Web-NSG" `
  -SecurityRules @($ruleHTTP, $ruleRDP)
