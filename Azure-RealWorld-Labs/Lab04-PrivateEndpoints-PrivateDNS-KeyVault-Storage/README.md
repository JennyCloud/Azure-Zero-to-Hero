# Lab04 - Private Endpoints & Private DNS  
### Secure Azure Storage and Key Vault (Bicep + GitHub Actions)

---

## 🔍 Overview
This lab demonstrates how to deploy **private-only Azure PaaS services** using **Bicep** and **GitHub Actions (OIDC)**, following real-world **enterprise / MSP security patterns**. This lab is featured because private access, DNS, and identity are where most real Azure outages actually happen.

Both **Azure Storage** and **Azure Key Vault** are deployed with:
- 🚫 **No public network access**
- 🔐 **Private Endpoints only**
- 🌐 **Azure Private DNS integration**
- ⚙️ **Fully automated Infrastructure as Code**

The emphasis is on **secure data-plane design**, not portal-driven configuration.

---

## 🧩 Scenario (Real-World Context)
A customer requires:
- Storage accounts and Key Vaults **not exposed to the public internet**
- Access limited to **trusted VNets**
- Centralized DNS resolution without manual configuration
- Repeatable, auditable deployments using CI/CD

This pattern is commonly required in:
- Regulated industries
- Enterprise landing zones
- MSP-managed Azure environments

---

## 🏗️ Architecture
**Deployed components:**
- Virtual Network  
  - Workload subnet  
  - Private Endpoint subnet  
- Network Security Group (default deny inbound)
- Azure Storage Account (Blob)
- Azure Key Vault (RBAC-enabled)
- Private Endpoints  
  - Storage Blob  
  - Key Vault  
- Azure Private DNS Zones  
  - `privatelink.blob.core.windows.net`  
  - `privatelink.vaultcore.azure.net`  
- Test Linux VM (no public IP)

All resources are deployed using **Bicep modules**, orchestrated by **GitHub Actions**.

---

## 🔐 Security Highlights
- ✅ Public network access **disabled** for Storage and Key Vault
- ✅ Data access restricted to **private IP space**
- ✅ No inbound connectivity required for validation
- ✅ Azure RBAC used for Key Vault (no access policies)
- ✅ No credentials stored in source control

---

## 🚀 Deployment
Deployment is fully automated using **GitHub Actions** with **OIDC authentication**.

### Trigger
- Manual: `workflow_dispatch`

### Workflow
.github/workflows/lab04-deploy.yml


### Required GitHub Secrets
| Secret Name | Description |
|------------|-------------|
| `AZURE_CLIENT_ID` | OIDC App Registration |
| `AZURE_TENANT_ID` | Azure AD Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Target Azure subscription |
| `LAB04_VM_PASSWORD` | Admin password for test VM |

---

## ✅ Validation
### Configuration Validation
The following are verified via Azure Portal:
- Private Endpoints are approved and connected
- Private DNS zones are linked to the VNet
- Storage and Key Vault have public access disabled
- Deployment completed successfully via GitHub Actions

### Optional Runtime Verification (Not Automated)
This lab **can** be further validated from inside the VNet by:
- Running commands via `az vm run-command`
- Using `nslookup` to confirm private DNS resolution
- Using `curl` to confirm private HTTPS connectivity

Runtime verification is intentionally **not automated** to keep the lab focused on **network and security architecture** rather than pipeline complexity.

---

## 🖼️ Screenshots
Included screenshots demonstrate:
- Successful GitHub Actions deployment
- Resource group contents
- Private-only networking configuration
- Private DNS integration

Refer to the `/screenshots` directory.

---

## 🧠 Key Learnings
- How Private Endpoints behave in real production environments
- Why Private DNS is essential for private PaaS access
- How to design secure, private-only data services
- How to deploy Azure infrastructure using Bicep + GitHub Actions
- Common failure modes (DNS misconfiguration, public access assumptions)
