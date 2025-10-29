# ==============================
# Mini Lab 3 — Single VM + IIS
# ==============================

# 1. Variables
$rg         = "LabLadder-RG"
$location   = "canadacentral"
$vnetName   = "LabVNet"
$subnetName = "WebSubnet"
$nsgName    = "WebSubnet-NSG"
$vmName     = "LabVM01"
$cred       = Get-Credential -Message "Enter local admin credentials for the VM"

# 2. Get existing network objects
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rg
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
$nsg = Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rg

# 3. Create a public IP address
$pip = New-AzPublicIpAddress `
  -Name "$vmName-pip" `
  -ResourceGroupName $rg `
  -Location $location `
  -AllocationMethod Static `
  -Sku Basic

# 4. Create a network interface and attach subnet + NSG + public IP
$nic = New-AzNetworkInterface `
  -Name "$vmName-nic" `
  -ResourceGroupName $rg `
  -Location $location `
  -Subnet $subnet `
  -PublicIpAddress $pip `
  -NetworkSecurityGroup $nsg

# 5. Create the virtual machine configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_B1s" |
  Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate |
  Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest" |
  Add-AzVMNetworkInterface -Id $nic.Id

# 6. Create the VM
New-AzVM -ResourceGroupName $rg -Location $location -VM $vmConfig

# 7. Install IIS inside the VM
Invoke-AzVMRunCommand `
  -ResourceGroupName $rg `
  -Name $vmName `
  -CommandId 'RunPowerShellScript' `
  -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools'

# 8. Output the public IP for browser testing
(Get-AzPublicIpAddress -Name "$vmName-pip" -ResourceGroupName $rg).IpAddress
