targetScope = 'resourceGroup'

param location string = resourceGroup().location
param prefix string = 'rwlab04'
param adminSourceCidr string = ''

param adminUsername string = 'azureuser'
@secure()
param adminPassword string


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

module peStgBlob './modules/privateEndpoint.bicep' = {
  name: 'peStgBlob'
  params: {
    location: location
    subnetId: net.outputs.privateEndpointSubnetId
    privateDnsZoneId: dns.outputs.storageBlobZoneId
    targetResourceId: stg.outputs.storageId
    groupId: 'blob'
    connectionName: '${prefix}-pe-stg-blob'
    nicName: '${prefix}-nic-pe-stg-blob'
    tags: tags
  }
}

module peKv './modules/privateEndpoint.bicep' = {
  name: 'peKv'
  params: {
    location: location
    subnetId: net.outputs.privateEndpointSubnetId
    privateDnsZoneId: dns.outputs.keyVaultZoneId
    targetResourceId: kv.outputs.keyVaultId
    groupId: 'vault'
    connectionName: '${prefix}-pe-kv'
    nicName: '${prefix}-nic-pe-kv'
    tags: tags
  }
}

output storagePrivateEndpointId string = peStgBlob.outputs.privateEndpointId
output keyVaultPrivateEndpointId string = peKv.outputs.privateEndpointId

module vm './modules/vmTest.bicep' = {
  name: 'vm'
  params: {
    location: location
    prefix: prefix
    subnetId: net.outputs.workloadSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    tags: tags
  }
}

output vmName string = vm.outputs.vmName




