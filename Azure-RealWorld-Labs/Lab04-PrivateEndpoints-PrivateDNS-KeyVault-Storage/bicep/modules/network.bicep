// Add network module (VNet + subnets + NSG)

param location string
param prefix string
param tags object
param adminSourceCidr string

var vnetName = '${prefix}-vnet'
var workloadSubnetName = 'snet-workload'
var peSubnetName = 'snet-private-endpoints'

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: '${prefix}-nsg-workload'
  location: location
  tags: tags
  properties: {
    securityRules: concat(
      [
        {
          name: 'Deny-Inbound-All'
          properties: {
            priority: 4096
            direction: 'Inbound'
            access: 'Deny'
            protocol: '*'
            sourcePortRange: '*'
            destinationPortRange: '*'
            sourceAddressPrefix: '*'
            destinationAddressPrefix: '*'
          }
        }
      ],
      empty(adminSourceCidr) ? [] : [
        {
          name: 'Allow-Admin-SSH'
          properties: {
            priority: 100
            direction: 'Inbound'
            access: 'Allow'
            protocol: 'Tcp'
            sourcePortRange: '*'
            destinationPortRange: '22'
            sourceAddressPrefix: adminSourceCidr
            destinationAddressPrefix: '*'
          }
        }
      ]
    )
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: { addressPrefixes: ['10.40.0.0/16'] }
    subnets: [
      {
        name: workloadSubnetName
        properties: {
          addressPrefix: '10.40.1.0/24'
          networkSecurityGroup: { id: nsg.id }
        }
      }
      {
        name: peSubnetName
        properties: {
          addressPrefix: '10.40.2.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output vnetName string = vnet.name
output workloadSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, workloadSubnetName)
output privateEndpointSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, peSubnetName)

