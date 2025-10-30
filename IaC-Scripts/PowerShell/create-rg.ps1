# =========================================
# File: create-rg.ps1
# Purpose: Create and verify a new Azure Resource Group
# =========================================

# Variables
$rgName   = "DemoLab-RG"
$location = "CanadaCentral"

# Create Resource Group
New-AzResourceGroup -Name $rgName -Location $location

# Confirm creation
Get-AzResourceGroup -Name $rgName

<#
=========================================================
Explanation:
- $rgName and $location store reusable values.
- New-AzResourceGroup creates a logical container for Azure resources.
- Get-AzResourceGroup verifies that the group exists.
Every Azure project begins with a Resource Group.
=========================================================
#>
