# 🧩 Azure ARM Templates Library

Welcome to the **ARM (Azure Resource Manager)** section of my **Infrastructure-as-Code (IaC)** collection.  
These templates define Azure infrastructure declaratively using JSON — describing **what** to deploy, not **how** to deploy it.  
Each file includes inline explanations for self-study and is designed for direct use in **Azure CLI**, **PowerShell**, or **DevOps pipelines**.

---

## 📘 Quick Navigation

| # | Template | Purpose |
|:-:|:--|:--|
| 1 | **[understanding-arm-syntax.json](./understanding-arm-syntax.json)** | Learn ARM structure: schema, parameters, variables, resources, and outputs. |
| 2 | **[create-vm-arm.json](./create-vm-arm.json)** | Deploy a standalone Virtual Machine with its network, public IP, and disk. |
| 3 | **[create-network-arm.json](./create-network-arm.json)** | Build a modular Virtual Network (VNet) with Subnet and NSG association. |
| 4 | **[create-loadbalancer-arm.json](./create-loadbalancer-arm.json)** | Create a Public Load Balancer with frontend, backend, probe, and rule. |
| 5 | **[create-vmss-arm.json](./create-vmss-arm.json)** | Deploy a Virtual Machine Scale Set (VMSS) linked to the Load Balancer. |
| 6 | **[configure-autoscale-arm.json](./configure-autoscale-arm.json)** | Add CPU-based autoscaling rules for VMSS (automatic scale in/out). |
| 7 | **[monitoring-and-alerts-arm.json](./monitoring-and-alerts-arm.json)** | Create Action Group, Metric Alert (CPU), and Activity Log Alert (autoscale events). |
| 8 | **[enable-loganalytics-and-dashboard-arm.json](./enable-loganalytics-and-dashboard-arm.json)** | Connect VMSS to Log Analytics and deploy a live monitoring dashboard. |

---

## 🧭 Recommended Learning Path

1. **Start Simple →** `understanding-arm-syntax.json`  
   Learn how ARM templates are structured and validated.  
2. **Provision Core →** VMs, Networks, and Load Balancers.  
3. **Scale →** Use VMSS for elastic compute.  
4. **Automate →** Enable autoscaling policies.  
5. **Observe →** Add monitoring, alerting, and dashboards.  

Following this sequence takes you from **foundations to full-scale observability** — all in pure JSON.

---

## 🧱 Skills Demonstrated

- Declarative Infrastructure-as-Code using ARM  
- Modular, composable templates with dependencies (`dependsOn`)  
- Compute orchestration (VMs, VMSS)  
- Network topology (VNet, Subnet, NSG, Load Balancer)  
- Autoscaling and Azure Monitor integration  
- Observability through alerts, diagnostics, and dashboards  
- Use of built-in ARM functions like `resourceId()`, `concat()`, `uniqueString()`, and `reference()`  
- Parameterization and outputs for reusable design  

---

## 💡 Notes

- Templates are modular; you can deploy them separately or chain them together.  
- Inline explanations are stored in the `"__comment__"` section for easy learning.  
- Use `--parameters` to override defaults (e.g., VM name, region, thresholds).  
- All templates are compatible with **Azure DevOps**, **Bicep**, or **GitHub Actions** for CI/CD.  

---

🪴 *“Declarative code is architecture that speaks for itself — reproducible, consistent, and elegant.”*
