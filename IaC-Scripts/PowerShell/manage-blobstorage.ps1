# =========================================
# File: manage-blobstorage.ps1
# Purpose: Manage blob containers and files in Azure Storage using PowerShell
# =========================================

# ---------- Variables ----------
$rg        = "DemoLab-RG"
$storage   = "jennyazlabstorage01"
$container = "labfiles"
$localFile = "C:\Temp\sample.txt"      # Change this path to an existing file on your system
$download  = "C:\Temp\downloaded.txt"

# ---------- Step 1. Get Storage Context ----------
# The context authenticates you against a storage account
$ctx = (Get-AzStorageAccount -ResourceGroupName $rg -Name $storage).Context
Write-Host "Storage context retrieved successfully." -ForegroundColor Cyan

# ---------- Step 2. Create Container ----------
# If container doesn’t exist, create one
$existingContainer = Get-AzStorageContainer -Context $ctx -Name $container -ErrorAction SilentlyContinue
if (-not $existingContainer) {
    New-AzStorageContainer -Name $container -Context $ctx -Permission Blob | Out-Null
    Write-Host "Container '$container' created." -ForegroundColor Green
} else {
    Write-Host "Container '$container' already exists." -ForegroundColor Yellow
}

# ---------- Step 3. Upload Blob ----------
# Upload a local file into the container
Set-AzStorageBlobContent -File $localFile -Container $container -Blob (Split-Path $localFile -Leaf) -Context $ctx
Write-Host "File uploaded to Blob container successfully." -ForegroundColor Green

# ---------- Step 4. List Blobs ----------
Write-Host "`nListing blobs in container '$container':" -ForegroundColor Cyan
Get-AzStorageBlob -Container $container -Context $ctx | Select-Object Name, Length, LastModified | Format-Table

# ---------- Step 5. Download Blob ----------
$blobName = (Split-Path $localFile -Leaf)
Get-AzStorageBlobContent -Container $container -Blob $blobName -Destination $download -Context $ctx
Write-Host "Blob downloaded to $download" -ForegroundColor Green

# ---------- Step 6. Delete Blob (optional cleanup) ----------
# Uncomment below line to delete the uploaded blob
# Remove-AzStorageBlob -Container $container -Blob $blobName -Context $ctx -Force
# Write-Host "Blob deleted." -ForegroundColor Red

<#
=========================================================
Explanation:

1. STORAGE CONTEXT
   - A context object contains authentication info for your storage account.
   - It’s required for every blob, file, or queue operation.
   - Created using:
        (Get-AzStorageAccount -ResourceGroupName <rg> -Name <storage>).Context

2. CONTAINER
   - A container is like a folder in Blob Storage.
   - Permission levels: Private, Blob (anonymous read of blobs only), Container (anonymous list & read).

3. UPLOAD (Set-AzStorageBlobContent)
   - Uploads a local file as a blob to the specified container.
   - If blob exists, it overwrites it by default.

4. LIST BLOBS
   - Get-AzStorageBlob lists all files (blobs) in a container.
   - Useful for verifying uploads or finding blob names programmatically.

5. DOWNLOAD (Get-AzStorageBlobContent)
   - Downloads a blob from Azure back to your local path.

6. DELETE (Remove-AzStorageBlob)
   - Optional cleanup to remove test blobs.

Real-World Usage:
- Upload configuration files or web assets.
- Automate backups to Blob Storage.
- Use in pipelines (CI/CD) to publish build artifacts.

RESULT:
You can now fully manage Azure Blob Storage contents using PowerShell.
=========================================================
#>
