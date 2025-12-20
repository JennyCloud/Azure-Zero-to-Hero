targetScope = 'resourceGroup'

param location string = resourceGroup().location
param prefix string = 'rwlab04'
param adminSourceCidr string = ''

var tags = {
  Project: 'Azure-RealWorld-Labs'
  Lab: 'Lab04-PrivateEndpoints-PrivateDNS-KeyVault-Storage'
}

module net './modules/network.bicep' = {
  name: 'net'
  params: {
    location: location
    prefix: prefix
    tags: tags
    adminSourceCidr: adminSourceCidr
  }
}

output vnetName string = net.outputs.vnetName
output workloadSubnetId string = net.outputs.workloadSubnetId
output privateEndpointSubnetId string = net.outputs.privateEndpointSubnetId

module dns './modules/privateDns.bicep' = {
  name: 'dns'
  params: {
    prefix: prefix
    vnetId: net.outputs.vnetId
    tags: tags
  }
}

output storageBlobZoneId string = dns.outputs.storageBlobZoneId
output keyVaultZoneId string = dns.outputs.keyVaultZoneId

module stg './modules/storage.bicep' = {
  name: 'stg'
  params: {
    location: location
    prefix: prefix
    tags: tags
  }
}

output storageName string = stg.outputs.storageName
output storageId string = stg.outputs.storageId

module kv './modules/keyvault.bicep' = {
  name: 'kv'
  params: {
    location: location
    prefix: prefix
    tenantId: subscription().tenantId
    tags: tags
  }
}

output keyVaultName string = kv.outputs.keyVaultName
output keyVaultId string = kv.outputs.keyVaultId


