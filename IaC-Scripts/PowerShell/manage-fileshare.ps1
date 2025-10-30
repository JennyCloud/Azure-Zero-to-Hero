# =========================================
# File: manage-fileshare.ps1
# Purpose: Create, list, upload, download, and delete Azure File Shares
# =========================================

# ---------- Variables ----------
$rg        = "DemoLab-RG"
$storage   = "jennyazlabstorage01"
$shareName = "shareddata"
$localPath = "C:\Temp\notes.txt"        # Change to an existing file path
$download  = "C:\Temp\downloaded-notes.txt"

# ---------- Step 1. Get Storage Context ----------
$ctx = (Get-AzStorageAccount -ResourceGroupName $rg -Name $storage).Context
Write-Host "Storage context retrieved." -ForegroundColor Cyan

# ---------- Step 2. Create File Share ----------
$existingShare = Get-AzStorageShare -Name $shareName -Context $ctx -ErrorAction SilentlyContinue
if (-not $existingShare) {
    New-AzStorageShare -Name $shareName -Context $ctx | Out-Null
    Write-Host "File share '$shareName' created." -ForegroundColor Green
} else {
    Write-Host "File share '$shareName' already exists." -ForegroundColor Yellow
}

# ---------- Step 3. Upload File ----------
Set-AzStorageFileContent -ShareName $shareName -Source $localPath -Path (Split-Path $localPath -Leaf) -Context $ctx
Write-Host "File uploaded to Azure File Share successfully." -ForegroundColor Green

# ---------- Step 4. List Files ----------
Write-Host "`nFiles in share '$shareName':" -ForegroundColor Cyan
Get-AzStorageFile -ShareName $shareName -Context $ctx | Select-Object Name, Length, LastModified | Format-Table

# ---------- Step 5. Download File ----------
$filename = (Split-Path $localPath -Leaf)
Get-AzStorageFileContent -ShareName $shareName -Path $filename -Destination $download -Context $ctx
Write-Host "File downloaded to $download" -ForegroundColor Green

# ---------- Step 6. Delete File (optional) ----------
# Uncomment to delete
# Remove-AzStorageFile -ShareName $shareName -Path $filename -Context $ctx -Force
# Write-Host "File deleted from Azure File Share." -ForegroundColor Red

# ---------- Step 7. Map File Share Locally (Windows only) ----------
# You can map the share like a network drive using the storage key:
# $keys = Get-AzStorageAccountKey -ResourceGroupName $rg -Name $storage
# $key  = $keys[0].Value
# net use Z: "\\$storage.file.core.windows.net\$shareName" /u:Azure\$storage $key

<#
=========================================================
Explanation:

1. FILE SHARE vs BLOB CONTAINER
   - File shares (SMB protocol) support file/folder hierarchy and can be mounted as drives (Z:).
   - Blob storage (REST API) is optimized for apps and static content.

2. STORAGE CONTEXT
   - Same concept as blob operations; authenticates every file operation.

3. CREATE FILE SHARE
   - New-AzStorageShare creates the share if it doesn’t exist.
   - Get-AzStorageShare verifies existing shares.

4. UPLOAD / DOWNLOAD
   - Set-AzStorageFileContent uploads a local file to the share.
   - Get-AzStorageFileContent downloads it back.

5. MAP DRIVE (optional)
   - Use Windows “net use” command to mount the file share with your storage key.
   - It appears as a network drive (Z:\) just like on-prem file servers.

6. REAL-WORLD USES
   - Host configuration files shared by multiple VMs.
   - Lift legacy applications that depend on file shares.
   - Centralized log storage or backups.

RESULT:
You can now create and manage Azure File Shares entirely from PowerShell.
=========================================================
#>
