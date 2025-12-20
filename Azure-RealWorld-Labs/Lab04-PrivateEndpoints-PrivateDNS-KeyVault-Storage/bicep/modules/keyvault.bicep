param location string
param prefix string
param tenantId string
param tags object

var kvName = toLower(replace('${prefix}-kv-${uniqueString(resourceGroup().id)}', '--', '-'))

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: kvName
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }

    // Use Azure RBAC instead of access policies
    enableRbacAuthorization: true

    // Private-only
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }

    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
  }
}

output keyVaultId string = kv.id
output keyVaultName string = kv.name
