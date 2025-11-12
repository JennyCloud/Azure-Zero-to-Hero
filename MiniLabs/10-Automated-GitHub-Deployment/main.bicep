resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: uniqueString(resourceGroup().id, 'ml10')
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
