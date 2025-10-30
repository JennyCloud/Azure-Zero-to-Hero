# ⚙️ Azure PowerShell Scripts Library

Welcome to the **PowerShell** section of my **Infrastructure-as-Code (IaC)** collection.  
These scripts automate real-world Azure administration tasks — from deploying VMs and Scale Sets to enabling autoscale, alerts, and monitoring dashboards.

Each script is self-contained, fully commented, and designed for hands-on learning or portfolio demonstration.

---

## 📘 Quick Navigation

| # | Script | Purpose |
|:-:|:--|:--|
| 1 | **[understanding-powershell-syntax.ps1](./understanding-powershell-syntax.ps1)** | Learn the structure of Azure PowerShell cmdlets and syntax basics. |
| 2 | **[create-rg.ps1](./create-rg.ps1)** | Create a new Azure Resource Group (the foundation for all resources). |
| 3 | **[create-vm.ps1](./create-vm.ps1)** | Deploy a Windows Server VM with basic networking and RDP access. |
| 4 | **[manage-vm.ps1](./manage-vm.ps1)** | Start, stop, restart, or delete an existing VM safely. |
| 5 | **[create-network.ps1](./create-network.ps1)** | Build a Virtual Network, Subnet, NSG, and Public IP configuration. |
| 6 | **[create-storage.ps1](./create-storage.ps1)** | Create a Storage Account, blob container, and upload a sample file. |
| 7 | **[assign-role.ps1](./assign-role.ps1)** | Assign RBAC roles (e.g., Blob Data Contributor) to users securely. |
| 8 | **[create-vmss-with-loadbalancer.ps1](./create-vmss-with-loadbalancer.ps1)** | Deploy a VM Scale Set behind a Load Balancer with health probes. |
| 9 | **[scale-vmss.ps1](./scale-vmss.ps1)** | Manually scale, restart, or update an existing VM Scale Set. |
| 10 | **[autoscale-policy.ps1](./autoscale-policy.ps1)** | Configure autoscale rules based on CPU usage thresholds. |
| 11 | **[monitoring-and-alerts.ps1](./monitoring-and-alerts.ps1)** | Set up action groups, metric alerts, and autoscale notifications. |
| 12 | **[enable-loganalytics-and-dashboard.ps1](./enable-loganalytics-and-dashboard.ps1)** | Link VMSS to Log Analytics and create a visual performance dashboard. |
| 13 | **[query-loganalytics.ps1](./query-loganalytics.ps1)** | Run KQL (Kusto Query Language) queries directly from PowerShell. |

---

## 🧭 Recommended Learning Path

If you’re new to Azure scripting, follow this progression:

1. **Syntax →** Start with `understanding-powershell-syntax.ps1`  
2. **Core Setup →** Create resource groups, networks, and VMs  
3. **Compute Automation →** Deploy and scale VMSS  
4. **Monitoring →** Add alerts, diagnostics, and dashboards  
5. **Analysis →** Query data in Log Analytics with KQL  

Each script builds upon the previous, mirroring a real Azure administrator workflow.

---

## 🧩 Skills Demonstrated

- Azure Resource Management (ARM) via PowerShell  
- Infrastructure as Code (IaC) automation  
- Role-Based Access Control (RBAC)  
- VMSS scaling and autoscaling strategies  
- Azure Monitor, Log Analytics, and KQL querying  
- DevOps-ready modular scripting practices  

---

## 💡 Notes

- Run all scripts in **Azure Cloud Shell** or a **PowerShell session with Az module installed**.  
- Replace placeholders (e.g., `you@example.com`, region names, resource group names) with your own values.  
- Scripts are modular — you can run them individually or chain them for full deployments.  
- Comments (`#` and `<# ... #>`) are detailed so the repo doubles as a learning guide.

---

🪴 *“Automation isn’t about replacing humans — it’s about amplifying what we can build.”*
