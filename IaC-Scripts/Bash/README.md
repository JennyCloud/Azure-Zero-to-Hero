# 🐚 Azure Bash Scripts Library

Welcome to the **Bash** section of my **Infrastructure-as-Code (IaC)** collection.  
These scripts use the **Azure CLI** (`az`) to automate common administration tasks — from creating resource groups and VMs to configuring load balancers, VM Scale Sets, and full monitoring pipelines.

Each file is fully commented for readability and ready to execute in **Azure Cloud Shell**, **WSL**, or any Linux terminal with the Azure CLI installed.

---

## 📘 Quick Navigation

| # | Script | Purpose |
|:-:|:--|:--|
| 1 | **[understanding-bash-syntax.sh](./understanding-bash-syntax.sh)** | Learn Bash and Azure CLI basics — variables, conditions, and the `az` command structure. |
| 2 | **[create-rg.sh](./create-rg.sh)** | Create and verify Azure Resource Groups. |
| 3 | **[create-vm.sh](./create-vm.sh)** | Deploy a Windows Server VM (or Linux) with public access for RDP/SSH. |
| 4 | **[create-network.sh](./create-network.sh)** | Build a custom VNet, Subnet, NSG, and Public IP. |
| 5 | **[create-loadbalancer.sh](./create-loadbalancer.sh)** | Deploy a public Load Balancer with frontend, backend, probe, and rule. |
| 6 | **[create-vmss.sh](./create-vmss.sh)** | Create a Virtual Machine Scale Set (VMSS) linked to the Load Balancer. |
| 7 | **[configure-autoscale.sh](./configure-autoscale.sh)** | Configure autoscaling rules for the VMSS based on CPU thresholds. |
| 8 | **[monitoring-and-alerts.sh](./monitoring-and-alerts.sh)** | Create Action Groups and Metric/Activity Log alerts for scaling and CPU usage. |
| 9 | **[enable-loganalytics-and-dashboard.sh](./enable-loganalytics-and-dashboard.sh)** | Connect VMSS to Log Analytics and deploy a monitoring dashboard. |

---

## 🧭 Recommended Learning Path

1. **Start simple →** `understanding-bash-syntax.sh`  
2. **Provision core resources →** resource group, VM, network  
3. **Add resilience →** load balancer + VM Scale Set  
4. **Automate growth →** autoscale policies  
5. **Observe everything →** alerts, Log Analytics, dashboard  

Each script builds on the previous one, creating a full **end-to-end Azure deployment pipeline** using Bash automation.

---

## 🧩 Skills Demonstrated

- Azure CLI automation (`az group`, `az vm`, `az network`, `az monitor`, `az deployment`)  
- VM Scale Set creation and autoscaling configuration  
- Network design: VNet + Subnet + NSG + Load Balancer  
- Monitoring setup (metrics, alerts, Log Analytics, dashboards)  
- Scripting best practices: variables, conditions, reusability, output formatting  

---

## 💡 Notes

- All scripts are **idempotent**: safe to re-run without creating duplicates.  
- Replace placeholder values (`you@example.com`, names, regions) before running.  
- Use `chmod +x <script>.sh` to make each file executable.  
- The scripts default to the `canadacentral` region; update if needed.  
- `--output table` gives human-readable output; change to `json` for automation.  

---

🪴 *“When code builds infrastructure, the cloud becomes poetry in motion.”*
