// ===============================
// Lab 01 - Understanding Bicep Syntax
// Author: Jenny Wang
// Description: Basic structure of a Bicep file, showing parameters,
// variables, resources, and outputs.
// ===============================

// ---------- Step 1: Define parameters ----------
// Parameters are user inputs when you deploy the template.
// Similar to 'parameters' in ARM JSON.

@description('Name of the storage account')
param storageAccountName string = 'jennystorage${uniqueString(resourceGroup().id)}'

@description('Azure region for deployment')
param location string = resourceGroup().location

// ---------- Step 2: Define variables ----------
// Variables store calculated values for reuse.
// They are not visible after deployment.

var skuName = 'Standard_LRS'

// ---------- Step 3: Define resources ----------
// The "resource" keyword defines an Azure resource to deploy.
// Syntax: resource <symbolicName> '<resourceType>@<apiVersion>' = { ... }

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// ---------- Step 4: Define outputs ----------
// Outputs return useful info after deployment.

output storageAccountId string = storageAccount.id
output storageAccountPrimaryEndpoint string = storageAccount.properties.primaryEndpoints.blob
