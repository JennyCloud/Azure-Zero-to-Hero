param(
    [Parameter(Mandatory)]
    [string] $ResourceGroupName,

    [Parameter(Mandatory)]
    [string] $VmName,

    [Parameter(Mandatory)]
    [string] $StorageAccountName,

    [Parameter(Mandatory)]
    [string] $KeyVaultName
)

$ErrorActionPreference = "Stop"

Write-Host "======================================="
Write-Host " Lab04 – Private Access Verification"
Write-Host "======================================="
Write-Host ""

# Build the shell script that will run INSIDE the VM
$inVmScript = @"
set -e

echo "=== DNS Resolution Checks ==="
echo ""
echo "Storage Account:"
nslookup ${StorageAccountName}.blob.core.windows.net

echo ""
echo "Key Vault:"
nslookup ${KeyVaultName}.vault.azure.net

echo ""
echo "=== HTTPS Connectivity Checks ==="
echo "(200 or 403 is acceptable – means private connectivity works)"
echo ""

echo "Storage Account:"
curl -I https://${StorageAccountName}.blob.core.windows.net | head -n 5

echo ""
echo "Key Vault:"
curl -I https://${KeyVaultName}.vault.azure.net | head -n 5

echo ""
echo "Verification completed successfully."
"@

$tempFile = New-TemporaryFile
Set-Content -Path $tempFile -Value $inVmScript -Encoding UTF8

Write-Host "Running verification inside VM using az vm run-command..."
Write-Host ""

az vm run-command invoke `
    --resource-group $ResourceGroupName `
    --name $VmName `
    --command-id RunShellScript `
    --scripts @$tempFile

Write-Host ""
Write-Host "======================================="
Write-Host " Verification finished"
Write-Host "======================================="
