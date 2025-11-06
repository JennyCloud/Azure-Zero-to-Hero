@description('Admin username for all VMs')
param adminUsername string = 'azureuser'

@description('Admin password for all VMs')
@secure()
param adminPassword string

@description('Location for all resources')
param location string = resourceGroup().location

@description('Number of VMs to deploy')
param vmCount int = 10

@description('VM size')
param vmSize string = 'Standard_B1s'

@description('Windows image to use')
param vmImage string = 'MicrosoftWindowsServer:WindowsServer:2022-Datacenter:latest'

var vnetName = 'vmfleet-vnet'
var subnetName = 'vmfleet-subnet'

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: { addressPrefixes: [ '10.0.0.0/16' ] }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource publicIPs 'Microsoft.Network/publicIPAddresses@2023-05-01' = [for i in range(1, vmCount + 1): {
  name: 'vm${i}-pip'
  location: location
  sku: { name: 'Basic' }
  properties: { publicIPAllocationMethod: 'Dynamic' }
}]

resource nics 'Microsoft.Network/networkInterfaces@2023-05-01' = [for i in range(1, vmCount + 1): {
  name: 'vm${i}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPs[i - 1].id
          }
        }
      }
    ]
  }
}]

resource vms 'Microsoft.Compute/virtualMachines@2023-03-01' = [for i in range(1, vmCount + 1): {
  name: 'vm${i}'
  location: location
  properties: {
    hardwareProfile: { vmSize: vmSize }
    osProfile: {
      computerName: 'vm${i}'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: split(vmImage, ':')[0]
        offer: split(vmImage, ':')[1]
        sku: split(vmImage, ':')[2]
        version: split(vmImage, ':')[3]
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nics[i - 1].id
        }
      ]
    }
  }
  dependsOn: [
    nics
  ]
}]
