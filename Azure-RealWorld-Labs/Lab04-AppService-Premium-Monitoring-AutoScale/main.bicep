// =============================================================
// 💎 Lab 04 – App Service PremiumV3 with Monitoring & AutoScale
// Date: November 2025
// =============================================================

@description('Location for all resources')
param location string = resourceGroup().location

@description('Base name prefix for resources')
param baseName string = 'appservice${uniqueString(resourceGroup().id)}'

// 1️⃣ App Service Plan (PremiumV3)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${baseName}-plan'
  location: location
  sku: {
    name: 'P1v3'
    tier: 'PremiumV3'
    size: 'P1v3'
    capacity: 1
  }
  properties: {
    reserved: false
    perSiteScaling: false
  }
  tags: {
    Lab: 'Azure-RealWorld-Lab04'
  }
}

// 2️⃣ Application Insights (Monitoring)
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${baseName}-insights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

// 3️⃣ Web App (Production) with Managed Identity
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: baseName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
  dependsOn: [
    appServicePlan
    appInsights
  ]
  tags: {
    Tier: 'Premium'
  }
}

// 4️⃣ Staging Slot (Blue-Green testing)
resource stagingSlot 'Microsoft.Web/sites/slots@2022-03-01' = {
  name: '${webApp.name}/staging'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  dependsOn: [webApp]
}

// 5️⃣ Autoscale (CPU > 70% → +1 instance)
resource autoscale 'Microsoft.Insights/autoscalesettings@2015-04-01' = {
  name: '${baseName}-autoscale'
  location: location
  properties: {
    enabled: true
    targetResourceUri: appServicePlan.id
    profiles: [
      {
        name: 'DefaultProfile'
        capacity: {
          minimum: '1'
          maximum: '2'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'CpuPercentage'
              metricResourceUri: appServicePlan.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT10M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 70
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT10M'
            }
          }
        ]
      }
    ]
  }
  dependsOn: [appServicePlan]
}

// ✅ Outputs
output productionUrl string = 'https://${webApp.name}.azurewebsites.net'
output stagingUrl string    = 'https://${webApp.name}-staging.azurewebsites.net'
output appInsightsName string = appInsights.name
