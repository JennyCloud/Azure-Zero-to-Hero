# ⚙️ Azure PowerShell Scripts Library

Welcome to the **PowerShell** section of my **Infrastructure-as-Code (IaC)** collection.  
These scripts automate real-world Azure administration tasks — from provisioning and scaling resources to securing, monitoring, and managing storage.

Each script is self-contained, fully commented, and designed for both **learning** and **practical use**.

---

## 📘 Quick Navigation

| # | Script | Purpose |
|:-:|:--|:--|
| 1 | **[understanding-powershell-syntax.ps1](./understanding-powershell-syntax.ps1)** | Learn how Azure PowerShell cmdlets are structured and used. |
| 2 | **[create-rg.ps1](./create-rg.ps1)** | Create a new Resource Group as a container for your Azure resources. |
| 3 | **[create-vm.ps1](./create-vm.ps1)** | Deploy a Windows Server VM with networking and RDP access. |
| 4 | **[manage-vm.ps1](./manage-vm.ps1)** | Start, stop, restart, or remove existing VMs. |
| 5 | **[create-network.ps1](./create-network.ps1)** | Build a Virtual Network (VNet), Subnet, NSG, and Public IP. |
| 6 | **[create-storage.ps1](./create-storage.ps1)** | Create a Storage Account and upload basic test files. |
| 7 | **[assign-role.ps1](./assign-role.ps1)** | Grant users specific RBAC roles (e.g., Blob Data Contributor). |
| 8 | **[create-vmss-with-loadbalancer.ps1](./create-vmss-with-loadbalancer.ps1)** | Deploy a Virtual Machine Scale Set (VMSS) with a Load Balancer. |
| 9 | **[scale-vmss.ps1](./scale-vmss.ps1)** | Manually scale, restart, or update an existing VM Scale Set. |
| 10 | **[autoscale-policy.ps1](./autoscale-policy.ps1)** | Configure autoscaling rules for VMSS based on CPU thresholds. |
| 11 | **[monitoring-and-alerts.ps1](./monitoring-and-alerts.ps1)** | Create action groups, metric alerts, and autoscale notifications. |
| 12 | **[enable-loganalytics-and-dashboard.ps1](./enable-loganalytics-and-dashboard.ps1)** | Connect VMSS to Log Analytics and build a monitoring dashboard. |
| 13 | **[query-loganalytics.ps1](./query-loganalytics.ps1)** | Run KQL (Kusto Query Language) queries from PowerShell. |
| 14 | **[manage-blobstorage.ps1](./manage-blobstorage.ps1)** | Manage blob containers: upload, list, download, and delete files. |
| 15 | **[manage-fileshare.ps1](./manage-fileshare.ps1)** | Create and manage Azure File Shares (SMB) for shared storage. |
| 16 | **[generate-sas-token.ps1](./generate-sas-token.ps1)** | Generate secure SAS tokens for temporary, limited access to storage. |

---

## 🧭 Recommended Learning Path

If you’re learning PowerShell for Azure, follow this order for the smoothest progression:

1. **Syntax & Basics →** `understanding-powershell-syntax.ps1`  
2. **Core Infrastructure →** Resource Groups, Networks, and VMs  
3. **Compute Automation →** VM Scale Sets and scaling policies  
4. **Monitoring & Observability →** Alerts, Log Analytics, Dashboards, and KQL  
5. **Storage Mastery →** Blob, File Share, and SAS management  

Each script builds on the last — by the end, you’ll have a complete, modular toolkit for Azure administration.

---

## 🧩 Skills Demonstrated

- Azure Resource Manager (ARM) automation via PowerShell  
- VMSS provisioning and scaling (manual + automatic)  
- Network and security configuration (VNet, NSG, Load Balancer)  
- Storage management (Blob, File Share, SAS, lifecycle)  
- Azure Monitor integration (alerts, dashboards, Log Analytics)  
- Role-Based Access Control (RBAC) and least-privilege principles  
- KQL analytics for performance insights  

---

## 💡 Notes

- All scripts are safe to run in **Azure Cloud Shell** or **local PowerShell with the Az module** installed.  
- Replace placeholder values (e.g., resource group names, email addresses) with your own.  
- Each script includes detailed in-line comments (`#`) and full explanations in Markdown-style blocks (`<# ... #>`).  
- Modular design means you can use scripts individually or chain them in CI/CD workflows.  

---

🪴 *“Automation turns routine into reliability — code it once, run it forever.”*
