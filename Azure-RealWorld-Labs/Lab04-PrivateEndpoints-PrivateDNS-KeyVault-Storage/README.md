# Lab04 – Private Endpoints + Private DNS (Storage & Key Vault)

## Overview
This lab demonstrates how to deploy **private-only PaaS services** in Azure using **Bicep** and **GitHub Actions (OIDC)**, following a real-world enterprise / MSP security pattern.

Both **Azure Storage** and **Azure Key Vault** are:
- Deployed with **public network access disabled**
- Accessed **only via Private Endpoints**
- Integrated with **Azure Private DNS Zones**
- Fully automated using **Infrastructure as Code**

This lab focuses on **secure data-plane design**, not portal clicking.

---

## Scenario (Real-World Context)
A customer requires:
- Storage accounts and Key Vaults **not exposed to the public internet**
- Access allowed **only from inside a trusted VNet**
- Centralized DNS resolution without custom hosts files
- Automated, repeatable deployments for auditability

This is a common requirement in:
- Regulated environments
- Enterprise landing zones
- MSP-managed customer subscriptions

---

## Architecture
**Components deployed:**
- Virtual Network
  - Workload subnet
  - Private Endpoint subnet
- Network Security Group (default deny inbound)
- Azure Storage Account (Blob)
- Azure Key Vault (RBAC-enabled)
- Private Endpoints:
  - Storage Blob
  - Key Vault
- Azure Private DNS Zones:
  - `privatelink.blob.core.windows.net`
  - `privatelink.vaultcore.azure.net`
- Test Linux VM (no public IP)

All resources are deployed via **Bicep** and orchestrated using **GitHub Actions**.

---

## Security Highlights
- ✅ Public network access **disabled** on Storage and Key Vault
- ✅ Data access restricted to **private IP space**
- ✅ No inbound connectivity required to validate deployment
- ✅ Azure RBAC used for Key Vault (no access policies)
- ✅ No secrets stored in source control

---

## Deployment Method
Deployment is fully automated using **GitHub Actions** with **OIDC authentication**.

### Trigger
- Manual: `workflow_dispatch`

### Workflow location
.github/workflows/lab04-deploy.yml


### Required GitHub Secrets
| Name | Purpose |
|-----|--------|
| `AZURE_CLIENT_ID` | OIDC App Registration |
| `AZURE_TENANT_ID` | Azure AD Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Target Subscription |
| `LAB04_VM_PASSWORD` | Admin password for test VM |

---

## Validation
### Configuration Validation (Current)
The following are verified via Azure Portal:
- Private Endpoints are approved and connected
- Private DNS zones are linked to the VNet
- Storage and Key Vault have public access disabled
- Resources are deployed via GitHub Actions

### Optional Runtime Verification (Not Automated)
This lab **can** be further validated by running DNS and HTTPS checks from the test VM using:
- `az vm run-command`
- `nslookup` to confirm private IP resolution
- `curl` to confirm private HTTPS connectivity

Automation of runtime verification is intentionally omitted to keep the lab focused on **network and security design** rather than pipeline complexity.

---

## Screenshots
Screenshots are included to demonstrate:
- Successful GitHub Actions deployment
- Resource group contents
- Private-only networking configuration
- Private DNS integration

See the `/screenshots` folder.

---

## Key Learnings
- How Private Endpoints actually work in production
- Why Private DNS is critical for PaaS private access
- How to design private-only data services
- How to deploy secure Azure infrastructure using Bicep + GitHub Actions
- Common failure points (DNS misconfiguration, public access assumptions)

