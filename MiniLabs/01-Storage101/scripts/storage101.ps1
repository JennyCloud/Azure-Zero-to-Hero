# ============================
# Mini Lab 1 — Azure Storage 101
# ============================

# Set variables
$rg = "LabLadder-RG"
$location = "canadacentral"
$saName = ("jennylab" + (Get-Random -Maximum 99999))
$container = "labcontainer"

# Create the storage account
$sa = New-AzStorageAccount `
  -ResourceGroupName $rg `
  -Name $saName `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind StorageV2

# Capture context (connection details)
$ctx = $sa.Context

# Create a private blob container
New-AzStorageContainer -Name $container -Context $ctx -Permission Off | Out-Null

# Create and upload a text file
Set-Content -Path "/home/$env:USER/labnote.txt" -Value "Hello from Mini 1!"
Set-AzStorageBlobContent `
  -File "/home/$env:USER/labnote.txt" `
  -Container $container `
  -Blob "labnote.txt" `
  -Context $ctx `
  -Force | Out-Null

# Generate a 1-hour read-only SAS URL
$start = (Get-Date).AddMinutes(-5)
$end = (Get-Date).AddHours(1)
$policy = New-AzStorageContainerSASToken `
  -Name $container -Context $ctx `
  -Permission r -StartTime $start -ExpiryTime $end

$sasUrl = ($sa.PrimaryEndpoints.Blob + $container + "/labnote.txt?" + $policy.TrimStart("?"))
Write-Host "SAS URL:" $sasUrl
