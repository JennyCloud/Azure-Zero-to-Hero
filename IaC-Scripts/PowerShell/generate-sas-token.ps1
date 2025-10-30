# =========================================
# File: generate-sas-token.ps1
# Purpose: Generate and use Shared Access Signature (SAS) tokens for Azure Storage
# =========================================

# ---------- Variables ----------
$rg        = "DemoLab-RG"
$storage   = "jennyazlabstorage01"
$container = "labfiles"
$blobName  = "sample.txt"     # change to an existing blob in your container
$duration  = 2                # SAS token duration in hours

# ---------- Step 1. Get Storage Context ----------
$ctx = (Get-AzStorageAccount -ResourceGroupName $rg -Name $storage).Context
Write-Host "Storage context retrieved for $storage." -ForegroundColor Cyan

# ---------- Step 2. Generate a Container-Level SAS Token ----------
$startTime = Get-Date
$expiryTime = $startTime.AddHours($duration)

# Create a SAS with read/list access to the entire container
$sasToken = New-AzStorageContainerSASToken `
  -Name $container `
  -Context $ctx `
  -Permission rl `
  -StartTime $startTime `
  -ExpiryTime $expiryTime

Write-Host "`nContainer SAS token generated (valid for $duration hours):" -ForegroundColor Green
Write-Host $sasToken
Write-Host ""

# ---------- Step 3. Build a Full URL for Sharing ----------
$containerUrl = (Get-AzStorageContainer -Name $container -Context $ctx).CloudBlobContainer.Uri.AbsoluteUri
$fullUrl = "$containerUrl?$sasToken"
Write-Host "Full SAS URL:" -ForegroundColor Cyan
Write-Host $fullUrl
Write-Host ""

# ---------- Step 4. Generate a Blob-Level SAS Token ----------
$blobSas = New-AzStorageBlobSASToken `
  -Container $container `
  -Blob $blobName `
  -Permission r `
  -StartTime $startTime `
  -ExpiryTime $expiryTime `
  -Context $ctx

$blobUrl = "$containerUrl/$blobName?$blobSas"
Write-Host "Blob SAS URL (read-only):" -ForegroundColor Cyan
Write-Host $blobUrl

# ---------- Step 5. Test (Optional) ----------
# You can paste the SAS URL in a browser to verify public read access.
# It should download or display the blob if the permissions are correct.

<#
=========================================================
Explanation:

1. WHAT IS A SAS TOKEN?
   - A Shared Access Signature (SAS) is a *temporary, limited-access key*
     that grants specific permissions to Azure Storage resources.
   - You can generate SAS tokens for:
       * The entire storage account (Account SAS)
       * A specific container or file share (Service SAS)
       * A single blob or file (Object SAS)
   - SAS = secure, time-bound alternative to sharing your master keys.

2. PERMISSIONS
   - r  → read
   - w  → write
   - d  → delete
   - l  → list
   - a  → add
   - c  → create
   - (Combine them as needed, e.g., "rwl" for read/write/list)

3. TIME WINDOW
   - StartTime and ExpiryTime define validity.
   - Best practice: keep SAS lifespan short (hours, not days).

4. USE CASES
   - Provide temporary download/upload URLs to external clients.
   - Automate file sharing between services.
   - Grant build pipelines or apps limited access to blob storage.

5. SECURITY BEST PRACTICES
   - Never commit SAS tokens to GitHub or public files.
   - Use HTTPS always (SAS tokens don’t encrypt by themselves).
   - Revoke tokens by regenerating storage account keys if compromised.

RESULT:
You can now securely generate, share, and control access
to blobs or containers without exposing your storage keys.
=========================================================
#>
