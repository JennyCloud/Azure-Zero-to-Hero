# 💬 Interview Q&A — Lab 3: Azure VM Scale Set with Load Balancer


### 🔹 Concept Overview

This lab demonstrates how to create a **Virtual Machine Scale Set (VMSS)** that automatically installs IIS on deployment and connects to an existing **Azure Load Balancer (LB)**.  
The architecture ensures **high availability**, **scalability**, and **automated management** of web servers under load.

---

### 💡 Common Interview Questions & Answers

#### 1. What is a Virtual Machine Scale Set (VMSS)?
A VM Scale Set is an Azure compute resource that allows you to deploy and manage a group of identical, load-balanced VMs.  
It supports auto-scaling and ensures application availability even under fluctuating demand.

---

#### 2. What’s the main difference between **VMSS** and creating multiple VMs manually?
Manually created VMs must be managed and updated one by one.  
A VMSS provides a **single configuration model** — all instances share the same OS image, extensions, and scaling rules, making updates and scaling much easier.

---

#### 3. What are the two orchestration modes for VMSS?
- **Uniform**: All instances are identical and managed as a group. Best for large web apps.  
- **Flexible**: Allows different VM sizes and configurations in one set. Best for mixed or stateful workloads.

---

#### 4. How does a Load Balancer distribute traffic to the VMSS?
The Azure Load Balancer distributes incoming traffic across all healthy VM instances using:
- **Backend pool** (where VMSS instances register their NICs)
- **Health probe** (to detect healthy nodes)
- **Load-balancing rule** (to define how traffic flows between frontend and backend)

---

#### 5. What’s the purpose of a **health probe** in the Load Balancer?
A health probe regularly checks the status of VM instances (e.g., port 80).  
If a VM fails to respond, it’s temporarily removed from the backend pool until it recovers.

---

#### 6. Why was IIS installed using **CustomData** instead of manually?
CustomData allows the VMSS to **self-configure at deployment** — a form of *bootstrap automation*.  
This ensures that every new instance that scales out automatically runs the same setup script (IIS installation in this case).

---

#### 7. What’s the advantage of using a **Uniform** VMSS with a Load Balancer?
- Simplifies horizontal scaling (add/remove instances easily)
- Ensures consistent configuration  
- Reduces maintenance overhead  
- Integrates seamlessly with auto-scaling and update domains

---

#### 8. How can you verify if IIS was installed correctly on all instances?
You can use Azure PowerShell to run a remote command across instances:
```powershell
Get-AzVmssVM -ResourceGroupName "LoadBalancer-Lab-RG" -VMScaleSetName "WebApp-VMSS-Uniform" |
ForEach-Object {
  Invoke-AzVmssVMRunCommand `
    -ResourceGroupName "LoadBalancer-Lab-RG" `
    -VMScaleSetName "WebApp-VMSS-Uniform" `
    -InstanceId $_.InstanceId `
    -CommandId 'RunPowerShellScript' `
    -ScriptString 'Get-Service -Name W3SVC'
}

---

