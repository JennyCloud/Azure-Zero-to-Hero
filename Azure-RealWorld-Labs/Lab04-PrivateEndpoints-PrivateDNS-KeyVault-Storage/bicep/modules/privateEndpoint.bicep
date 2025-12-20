param location string
param subnetId string
param privateDnsZoneId string
param targetResourceId string
param groupId string
param connectionName string
param nicName string
param tags object

resource pe 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: connectionName
  location: location
  tags: tags
  properties: {
    subnet: {
      id: subnetId
    }
    customNetworkInterfaceName: nicName
    privateLinkServiceConnections: [
      {
        name: '${connectionName}-pls'
        properties: {
          privateLinkServiceId: targetResourceId
          groupIds: [ groupId ]
        }
      }
    ]
  }
}

resource zoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  name: '${pe.name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'cfg'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}

output privateEndpointId string = pe.id
