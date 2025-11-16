# Lab 01 - Automate Deployment of Azure Compute Resources

## Overview
This lab automates the deployment of Azure compute resources using **Bicep**, **ARM templates**, and **GitHub Actions** with **OIDC authentication**. The goal was to deploy a full compute stack — virtual machine, network interface, virtual network, NSG, and public IP — without using the Azure Portal for provisioning. After deployment, the environment was exported as an ARM template and converted back into Bicep using Azure CLI on my local machine.

## Lab Resources
https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-104

**Deploy and manage Azure compute resources (20–25%)**

Automate deployment of resources by using Azure Resource Manager (ARM) templates or Bicep files
- Interpret an Azure Resource Manager template or a Bicep file
- Modify an existing Azure Resource Manager template
- Modify an existing Bicep file
- Deploy resources by using an Azure Resource Manager template or a Bicep file
- Export a deployment as an Azure Resource Manager template or convert an Azure Resource Manager template to a Bicep file

## Issues I Troubleshooted

### 1. Missing GitHub Secrets
The GitHub Actions workflow referenced secrets that did not exist (`AZURE_RG`, `ADMINPASSWORD`).  
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
This successfully produced a `template.bicep`.

## What Azure Administrators Do in Real Work

Azure Administrators spend most of their time managing and automating cloud environments, not clicking buttons in the portal. Real work often looks like a combination of scripting, monitoring, governance, troubleshooting, and lifecycle management. Below are the common tasks Azure Admins perform that relate directly to this lab:

### 1. Automate Deployments Using Templates
Azure Admins maintain and improve **Bicep**, **ARM**, and **Terraform** templates.  
They build reusable IaC modules for:

- Virtual machines
- Networking components (VNet, NSG, Subnets)
- Public IPs and load balancers
- Storage accounts
- App Services and databases

Automation reduces human error and ensures environments are recreated consistently.

### 2. Use Pipelines to Deploy Infrastructure
Instead of deploying manually, admins rely on pipelines such as:

- GitHub Actions  
- Azure DevOps Pipelines  
- Bicep CLI automation  

Pipelines validate templates, deploy to test subscriptions first, and enforce approval workflows for production.

This lab mirrors that workflow by using **GitHub Actions + OIDC**.

### 3. Manage Access and RBAC Permissions
Admins ensure the correct service principals, pipelines, and users have the proper access levels:

- Assigning roles like **Contributor**, **Reader**, **Network Contributor**, or custom roles
- Fixing issues where pipelines fail due to missing permissions
- Auditing and enforcing least privilege

### 4. Handle Region Limitations and Quotas
Real Azure environments often hit:

- Quota limits (CPU, Public IPs, VM SKUs)
- Image availability differences between regions
- Subscription-level restrictions
- Billing constraints

Admins constantly adapt templates to what is actually available in the region or subscription.

### 5. Troubleshoot Deployment Failures
Deployments fail often. Admins regularly fix issues such as:

- Invalid image references
- Missing parameters
- Resource conflicts
- Locked or busy resource groups
- "Not found in this region" errors
- Networking dependencies (NSG, NIC, subnet issues)

### 6. Export, Review, and Modernize Templates
Admins often export existing resources to:

- Reverse-engineer environments
- Convert ARM → Bicep
- Update older JSON templates to cleaner Bicep syntax

This is a common part of migrating legacy workloads.

### 7. Maintain Environments Long-Term
Admins:

- Apply patches and updates to VMs
- Monitor logs and metrics
- Respond to incidents and alerts
- Rotate credentials and secrets
- Review cost reports
- Clean up unused resources
- Update automation pipelines regularly

Automation is only the beginning — operational excellence is the day-to-day work.

### Summary
Modern Azure Administrators are **automation-driven problem solvers**.  
They deploy, maintain, secure, optimize, monitor, and troubleshoot cloud workloads using a mixture of:

- Infrastructure as code (Bicep/ARM/Terraform)  
- CI/CD automation  
- RBAC & identity management  
- Region/subscription constraints  
- Logs, alerts, and monitoring tools  
