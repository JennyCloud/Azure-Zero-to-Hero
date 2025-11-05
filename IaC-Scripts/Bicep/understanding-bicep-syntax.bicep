// ===============================
// Lab 01 – Understanding Bicep Syntax
// Author: Jenny Wang
// Description: Basic structure of a Bicep file, showing parameters,
// variables, resources, and outputs.
// ===============================


// 💡 Explanation: Comments
// Use '//' for single-line comments and '/* ... */' for multi-line comments.
// Comments help explain what each section of the code does — something ARM JSON lacks.


// ---------- Step 1: Define parameters ----------
// 💡 Explanation:
// Parameters are user-defined inputs for the deployment.
// They make the template reusable by allowing different values
// to be passed in during deployment (e.g., storage account name, region).

@description('Name of the storage account')
param storageAccountName string = 'jennystorage${uniqueString(resourceGroup().id)}'

@description('Azure region for deployment')
param location string = resourceGroup().location


// ---------- Step 2: Define variables ----------
// 💡 Explanation:
// Variables hold reusable or computed values.
// They simplify the template and reduce repetition.
// Variables are local to this Bicep file and not visible after deployment.

var skuName = 'Standard_LRS'


// ---------- Step 3: Define resources ----------
// 💡 Explanation:
// The 'resource' keyword declares an Azure resource.
// Syntax: resource <symbolicName> '<resourceType>@<apiVersion>' = { ... }
// The symbolic name (like 'storageAccount') is how you refer to the resource within this file.

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName         // Uses the parameter defined above
  location: location               // Uses the resource group’s location
  sku: {
    name: skuName                  // Uses the variable defined above
  }
  kind: 'StorageV2'                // Type of storage account
  properties: {
    accessTier: 'Hot'              // Sets the access tier (Hot or Cool)
  }
}


// ---------- Step 4: Define outputs ----------
// 💡 Explanation:
// Outputs are the values returned after deployment.
// They’re helpful for chaining templates or verifying key properties (like resource IDs).

output storageAccountId string = storageAccount.id
output storageAccountPrimaryEndpoint string = storageAccount.properties.primaryEndpoints.blob


// 💡 Summary of Key Concepts
// 1. Parameters = Inputs (customizable values)
// 2. Variables  = Reusable logic or constants
// 3. Resources  = What you’re deploying
// 4. Outputs    = Returned values after deployment
// Bicep offers cleaner syntax, automatic dependency handling, and full ARM compatibility.
