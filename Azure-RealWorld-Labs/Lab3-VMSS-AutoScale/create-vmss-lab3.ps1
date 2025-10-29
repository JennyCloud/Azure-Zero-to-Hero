# ============================================
# Lab 3: Create VM Scale Set (VMSS) with Load Balancer Integration
# ============================================

# --- Parameters ---
$rg = "LoadBalancer-Lab-RG"
$location = "CanadaCentral"
$vnetName = "LB-Lab-VNet"
$lbName = "Web-LB"
$backendName = "LB-Backend"
$vmssName = "WebApp-VMSS-Uniform"

# --- Step 1: Retrieve existing network and load balancer ---
$vnet = Get-AzVirtualNetwork -ResourceGroupName $rg -Name $vnetName
$lb = Get-AzLoadBalancer -ResourceGroupName $rg -Name $lbName
$backendPool = Get-AzLoadBalancerBackendAddressPoolConfig -LoadBalancer $lb -Name $backendName

# --- Step 2: Define the VMSS configuration ---
$vmssConfig = New-AzVmssConfig `
  -Location $location `
  -SkuCapacity 1 `
  -SkuName "Standard_B1s" `
  -UpgradePolicyMode "Automatic" `
  -OrchestrationMode "Uniform"

# --- Step 3: Add networking linked to backend pool ---
Add-AzVmssNetworkInterfaceConfiguration `
  -VirtualMachineScaleSet $vmssConfig `
  -Name "vmss-nic" `
  -Primary $true `
  -IPConfiguration (New-AzVmssIPConfig `
      -Name "vmss-ipconfig" `
      -SubnetId $vnet.Subnets[0].Id `
      -LoadBalancerBackendAddressPoolsId $backendPool.Id) | Out-Null

# --- Step 4: OS and Image configuration ---
Set-AzVmssStorageProfile `
  -VirtualMachineScaleSet $vmssConfig `
  -ImageReferencePublisher "MicrosoftWindowsServer" `
  -ImageReferenceOffer "WindowsServer" `
  -ImageReferenceSku "2022-datacenter-smalldisk" `
  -ImageReferenceVersion "latest" `
  -OsDiskCreateOption "FromImage" | Out-Null

# --- Step 5: Admin account and IIS auto-install ---
$securePass = Read-Host -AsSecureString "Enter admin password"

Set-AzVmssOsProfile `
  -VirtualMachineScaleSet $vmssConfig `
  -ComputerNamePrefix "webvmss" `
  -AdminUsername "azureuser" `
  -AdminPassword $securePass `
  -CustomData ([Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("<powershell>
Install-WindowsFeature -Name Web-Server
Set-Content -Path 'C:\inetpub\wwwroot\index.html' -Value 'Hello from VMSS instance!'
</powershell>"))) | Out-Null

# --- Step 6: Create the VM Scale Set ---
New-AzVmss -ResourceGroupName $rg -Name $vmssName -VirtualMachineScaleSet $vmssConfig

Write-Host "✅ VMSS deployment complete. Check via: Get-AzVmss -ResourceGroupName $rg -VMScaleSetName $vmssName" -ForegroundColor Green
