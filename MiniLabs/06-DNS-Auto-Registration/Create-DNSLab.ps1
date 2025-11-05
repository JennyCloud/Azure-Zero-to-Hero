<#
=============================================================
 Lab 06 – Azure DNS Auto-Registration (Public vs. Private)
 Description:
   This script automates the setup of Lab 06 from the Azure Portal version.
   It deploys:
     - Resource Group
     - Virtual Network + Subnet
     - Two VMs (Windows + Ubuntu)
     - Public DNS Zone
     - Private DNS Zone with auto-registration
=============================================================
#>

# -----------------------------------------------------------
# STEP 1 – Define Variables
# -----------------------------------------------------------
$rgName     = "DNSLab-RG"
$location   = "CanadaCentral"
$vnetName   = "vnet1"
$subnetName = "subnet1"
$privateZone = "fabrikam.com"
$publicZone  = "contosotest.com"
$winVMName   = "vm1"
$linuxVMName = "vm2"

Write-Host "`n=== Lab 06: Azure DNS Auto-Registration ===`n" -ForegroundColor Cyan

# -----------------------------------------------------------
# STEP 2 – Create Resource Group
# -----------------------------------------------------------
Write-Host "Creating resource group $rgName..." -ForegroundColor Yellow
New-AzResourceGroup -Name $rgName -Location $location | Out-Null

# -----------------------------------------------------------
# STEP 3 – Create Virtual Network + Subnet
# -----------------------------------------------------------
Write-Host "Creating virtual network $vnetName and subnet $subnetName..." -ForegroundColor Yellow
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.1.0/24"

$vnet = New-AzVirtualNetwork -Name $vnetName `
    -ResourceGroupName $rgName `
    -Location $location `
    -AddressPrefix "10.0.0.0/16" `
    -Subnet $subnetConfig

# -----------------------------------------------------------
# STEP 4 – Create Virtual Machines
# -----------------------------------------------------------
Write-Host "`nCreating Windows Server VM ($winVMName)..." -ForegroundColor Yellow
$winCred = Get-Credential -Message "Enter credentials for Windows VM"
New-AzVM -ResourceGroupName $rgName `
    -Name $winVMName `
    -Location $location `
    -VirtualNetworkName $vnetName `
    -SubnetName $subnetName `
    -Image "Win2019Datacenter" `
    -Size "Standard_B1s" `
    -Credential $winCred | Out-Null

Write-Host "`nCreating Ubuntu VM ($linuxVMName)..." -ForegroundColor Yellow
$linuxCred = Get-Credential -Message "Enter credentials for Ubuntu VM"
New-AzVM -ResourceGroupName $rgName `
    -Name $linuxVMName `
    -Location $location `
    -VirtualNetworkName $vnetName `
    -SubnetName $subnetName `
    -Image "Ubuntu2204" `
    -Size "Standard_B1s" `
    -Credential $linuxCred | Out-Null

# -----------------------------------------------------------
# STEP 5 – Create DNS Zones (Public + Private)
# -----------------------------------------------------------
Write-Host "`nCreating public DNS zone $publicZone..." -ForegroundColor Yellow
New-AzDnsZone -Name $publicZone -ResourceGroupName $rgName | Out-Null

Write-Host "Creating private DNS zone $privateZone..." -ForegroundColor Yellow
New-AzPrivateDnsZone -Name $privateZone -ResourceGroupName $rgName | Out-Null

# -----------------------------------------------------------
# STEP 6 – Link Private DNS Zone to VNet with Auto-Registration
# -----------------------------------------------------------
Write-Host "Linking private DNS zone $privateZone to VNet ($vnetName)..." -ForegroundColor Yellow
New-AzPrivateDnsVirtualNetworkLink -Name "fabrikam-link" `
    -ResourceGroupName $rgName `
    -ZoneName $privateZone `
    -VirtualNetworkId $vnet.Id `
    -EnableRegistration:$true | Out-Null

# -----------------------------------------------------------
# STEP 7 – Summary Output
# -----------------------------------------------------------
Write-Host "`n=== Deployment Summary ===" -ForegroundColor Cyan
Write-Host "Resource Group:  $rgName"
Write-Host "Region:          $location"
Write-Host "VNet:            $vnetName (10.0.0.0/16)"
Write-Host "Subnet:          $subnetName (10.0.1.0/24)"
Write-Host "Windows VM:      $winVMName"
Write-Host "Ubuntu VM:       $linuxVMName"
Write-Host "Public DNS Zone: $publicZone"
Write-Host "Private DNS Zone: $privateZone (Auto-registration: Enabled)"
Write-Host "`nLab 06 setup complete! You can now verify DNS behavior from vm2." -ForegroundColor Green
