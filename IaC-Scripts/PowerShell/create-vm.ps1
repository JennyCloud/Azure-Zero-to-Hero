<#
.SYNOPSIS
Deploys a basic Windows Server VM with network components.
#>

$rg        = "DemoLab-RG"
$location  = "CanadaCentral"
$vmName    = "LabVM01"

# Prompt for admin credentials
$cred = Get-Credential

# Create VM (auto-creates dependent resources if missing)
New-AzVm `
  -ResourceGroupName $rg `
  -Name $vmName `
  -Location $location `
  -Image "Win2022Datacenter" `
  -Size "Standard_B1s" `
  -Credential $cred `
  -PublicIpAddressName "$vmName-pip" `
  -VirtualNetworkName "LabVNet" `
  -SubnetName "WebSubnet" `
  -SecurityGroupName "Web-NSG" `
  -OpenPorts 3389
