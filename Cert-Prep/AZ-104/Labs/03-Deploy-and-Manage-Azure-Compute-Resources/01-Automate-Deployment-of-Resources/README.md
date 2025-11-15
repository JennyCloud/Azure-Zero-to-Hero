# Lab 01: Automate Deployment of Azure Compute Resources

## Overview
This lab automates the deployment of Azure compute resources using **Bicep**, **ARM templates**, and **GitHub Actions** with **OIDC authentication**. The goal was to deploy a full compute stack — virtual machine, network interface, virtual network, NSG, and public IP — without using the Azure Portal for provisioning. After deployment, the environment was exported as an ARM template and converted back into Bicep using Azure CLI on my local machine.


## Issues I Troubleshooted

### 1. Missing GitHub Secrets
The GitHub Actions workflow referenced secrets that did not exist ('AZURE_RG', 'ADMINPASSWORD').  
**Fix:** Added the missing secrets in GitHub → Settings → Secrets and Variables → Actions.

### 2. GitHub OIDC Login but “No subscriptions found”
Azure login succeeded, but deployment failed with:
No subscriptions found for <app registration>
This meant the App Registration had **no RBAC access** to the subscription.  
**Fix:** Assigned **Contributor** role at the subscription scope to the GitHub OIDC App Registration.

### 3. Invalid VM Image Reference
Multiple Ubuntu SKUs were not available in my Azure region, causing:
imageReference not found: Canonical, Offer: UbuntuServer, Sku: 22_04-lts
**Fix:** Switched to a universally supported image:
Canonical / 0001-com-ubuntu-server-focal / 20_04-lts

### 4. Public IP Quota Limit Reached
Deployment failed with:
IPv4BasicSkuPublicIpCountLimitReached
Cannot create more than 0 IPv4 Basic SKU public IP addresses for this region.
**Fix:** Changed the Public IP to:
sku: Standard
publicIPAllocationMethod: Static
Standard SKU IPs were allowed in my subscription.

### 5. Cloud Shell Stuck in Ephemeral Mode
Cloud Shell kept showing:
Your Cloud Shell session will be ephemeral...
This prevented file uploads and ARM-to-Bicep decompilation.  
**Fix:** Instead of Cloud Shell, installed Azure CLI locally and ran:
az bicep decompile --file template.json
This successfully produced a 'template.bicep'.
