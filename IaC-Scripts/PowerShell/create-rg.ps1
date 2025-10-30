<#
.SYNOPSIS
Creates a new Azure Resource Group.
#>

# Variables
$rgName   = "DemoLab-RG"
$location = "CanadaCentral"

# Create the Resource Group
New-AzResourceGroup -Name $rgName -Location $location

# Confirm creation
Get-AzResourceGroup -Name $rgName
