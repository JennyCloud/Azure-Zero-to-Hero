@description('Location for all resources')
param location string = resourceGroup().location

@description('Admin username for the VM')
param adminUsername string = 'azureuser'

@description('Admin password for the VM')
@secure()
param adminPassword string

@description('Name of the VM')
param vmName string = 'labvm01'

@description('VM Size')

// Modification 2: Change the VM Size
// param vmSize string = 'Standard_B1s'
param vmSize string = 'Standard_B2s'

var vnetName = '${vmName}-vnet'
var subnetName = 'default'
var nsgName = '${vmName}-nsg'
var nicName = '${vmName}-nic'
var pipName = '${vmName}-pip'

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location

  // Modification 1: Add Resource Tags
  tags: {
    environment: 'lab'
    owner: 'jennycloud'
    purpose: 'az104-compute-lab'
  }

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'

        // Modification 4: Expand the VNet Address Space
        '10.1.0.0/16'

      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }

      // Modification 3: Add a New NSG Rule (Allow HTTP on Port 80)
      {
              name: 'AllowHTTP'
              properties: {
                priority: 1100
                direction: 'Inbound'
                access: 'Allow'
                protocol: 'Tcp'
                sourcePortRange: '*'
                destinationPortRange: '80'
                sourceAddressPrefix: '*'
                destinationAddressPrefix: '*'
        }
      }

    ]
  }
}

resource pip 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: pipName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: vnet.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location

  // Modification 1: Add Resource Tags
  tags: {
    environment: 'lab'
    owner: 'jennycloud'
    purpose: 'az104-compute-lab'
  }

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
       
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '22_04-lts'
        version: 'latest'

      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

output publicIP string = pip.properties.ipAddress
