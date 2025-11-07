# 🚀 Mini Lab 08 – Bicep VM Fleet (No Public IP Edition)

### 🎯 Goal
Deploy a fleet of internal-only Azure Virtual Machines (no public IPs) using a single **Bicep loop**.  
This lab demonstrates scalable Infrastructure as Code, resource dependencies, and Azure region management.

---

### 🧠 Key Concepts
- **Looping in Bicep** – `for i in range(1, vmCount + 1)` dynamically creates multiple VMs and NICs.
- **Parameterization** – Customize VM size, image, admin credentials, and count from a single parameters file.
- **Region Strategy** – Deploy to regions with available capacity (CentralUS in this case).
- **Quota Awareness** – Avoid Public IP and vCPU limits by deploying private VMs inside a shared VNet.

---

### ✅ Verification
- `vm1`, `vm2`, `vm3`, and `vm4` all in **Central US**
- Each VM has only a **private IP**
- Network: `vmfleet-vnet`
- NICs: `vm1-nic`, `vm2-nic`, `vm3-nic`, `vm4-nic`
- All resources deployed successfully using IaC

---

### 🧩 Issues & Troubleshooting

**1. Invalid template parsing in Azure CLI**
- **Issue:** Cloud Shell couldn’t deploy the Bicep file directly from GitHub and returned *“Failed to parse JSON”* errors.  
- **Fix:** Switched to local PowerShell, used `bicep build` to compile the `.bicep` file into `.json`, then deployed using `New-AzResourceGroupDeployment`.

**2. QuotaExceeded and ResourceCountExceedsLimitDueToTemplate**
- **Issue:** The original deployment with 10 VMs failed because the subscription only allowed **3 Public IPs** and **4 cores per region**.  
- **Fix:** Reduced `vmCount` from 10 → 3 and then removed public IP creation completely to stay within quotas.  

**3. SKU not available in East US**
- **Issue:** The selected VM size `Standard_B1s` was unavailable in *EastUS*.  
- **Fix:** Re-created the resource group in *CentralUS* where the SKU had capacity.

---

### 💡 Lessons Learned
- **Quota limits are real:** Default subscriptions limit the number of Public IPs and vCPUs per region. Initially, deploying 10 VMs failed because of Public IP and core quotas.  
- **Design adjustment:** Removed individual Public IPs and switched to an internal-only fleet to stay within limits.  
- **Region capacity matters:** East US reported unavailable SKUs, so the lab successfully redeployed to Central US, showing how regional capacity can affect automation.  
- **Bicep efficiency:** The looping syntax proved powerful for scaling deployments with minimal code — re-running the deployment safely updated existing infrastructure.  
- **Clean IaC pipeline:** GitHub → PowerShell → Azure resource verification provided a fully traceable workflow that mirrors enterprise DevOps practices.

---

### 🏆 Skills Demonstrated
✔ Azure Resource Manager & Bicep  
✔ PowerShell automation  
✔ Loop-based IaC design  
✔ Network & quota troubleshooting  
✔ GitHub-to-Azure deployment pipeline
