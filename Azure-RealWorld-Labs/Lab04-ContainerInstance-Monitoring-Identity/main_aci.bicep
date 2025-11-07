// =============================================================
// 💎 Azure RealWorld Lab 04 (ACI Edition) – Container + Insights + Identity
// =============================================================

@description('Location for all resources')
param location string = resourceGroup().location

@description('Base name prefix for resources')
param baseName string = 'aci${uniqueString(resourceGroup().id)}'

// 1️⃣ Log Analytics Workspace (used by Insights)
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: '${baseName}-logs'
  location: location
  properties: {}
}

// 2️⃣ Container Group (public HTTP demo)
resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: '${baseName}-cg'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    containers: [
      {
        name: 'hello'
        properties: {
          image: 'mcr.microsoft.com/azuredocs/aci-helloworld'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 1.5
            }
          }
          ports: [
            { port: 80 }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        { protocol: 'Tcp'; port: 80 }
      ]
    }
    diagnostics: {
      logAnalytics: {
        workspaceId: logAnalytics.properties.customerId
        logType: 'ContainerInsights'
      }
    }
  }
  dependsOn: [logAnalytics]
}

output containerFQDN string = containerGroup.properties.ipAddress.fqdn
