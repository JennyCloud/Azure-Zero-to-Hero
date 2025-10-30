# =========================================
# File: create-storage.ps1
# Purpose: Create a Storage Account, container, and upload a blob
# =========================================

$rg        = "DemoLab-RG"
$location  = "CanadaCentral"
$storage   = "jennyazlabstorage01"

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $rg -Name $storage -Location $location -SkuName Standard_LRS -Kind StorageV2

# Create a container
$ctx = (Get-AzStorageAccount -ResourceGroupName $rg -Name $storage).Context
New-AzStorageContainer -Name "labfiles" -Context $ctx -Permission Off

# Upload a file
Set-AzStorageBlobContent -File "index.html" -Container "labfiles" -Blob "index.html" -Context $ctx

<#
=========================================================
Explanation:
- Storage accounts hold Blobs, Files, Queues, and Tables.
- $ctx stores authentication context for the storage account.
- Set-AzStorageBlobContent uploads files (e.g., for web hosting).
A common admin task for backups, websites, or shared storage.
=========================================================
#>
