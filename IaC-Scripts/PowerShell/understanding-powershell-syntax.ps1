# =========================================
# File: understanding-powershell-syntax.ps1
# Purpose: Introduce Azure PowerShell fundamentals and syntax
# =========================================

<#
PowerShell scripts are built from cmdlets (command-lets).
Each cmdlet follows the pattern:

    Verb-AzNoun

where:
  Verb  = action (Get, New, Set, Remove, Start, Stop, etc.)
  Az    = Azure module prefix (Az PowerShell module)
  Noun  = Azure resource (Vm, ResourceGroup, StorageAccount, etc.)

This naming pattern makes scripts human-readable and consistent.
#>

# Example cmdlet
New-AzResourceGroup -Name "SyntaxDemo-RG" -Location "CanadaCentral"

<#
---------------------------------------------------------
Explanation:
- Verb-AzNoun = standard structure for Azure cmdlets.
- New-AzResourceGroup tells Azure to create a new Resource Group.
- Cmdlets often take parameters (prefixed with "-") to define options.

Common examples:
  Get-AzVm              → Retrieve info about virtual machines
  New-AzVm              → Create a new VM
  Remove-AzVm           → Delete a VM
  Set-AzNetworkSecurityGroup → Modify a network security group

Other PowerShell fundamentals:
- Variables: start with $, e.g., $name = "DemoVM"
- Pipelines (|): pass output from one cmdlet to another
- Backticks (`): allow multi-line commands
- Comments: use # for single-line or <# ... #> for blocks

PowerShell is not just a command runner — it’s a full automation language.
---------------------------------------------------------
#>
