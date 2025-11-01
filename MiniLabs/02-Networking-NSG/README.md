# 🌐 Mini Lab 2 — Azure Networking + NSG (PowerShell + Cloud Shell)

### 🧩 Objective  
Create a **Virtual Network (VNet)**, **Subnet**, and **Network Security Group (NSG)** with an inbound rule that allows HTTP (port 80) traffic.  
This lab introduces Azure’s core network and security concepts that protect all compute resources.

---

## 📜 Script Location  
All PowerShell commands are located in  
[`scripts/networking-nsg.ps1`](./scripts/networking-nsg.ps1)

Run it directly in **Azure Cloud Shell (PowerShell mode)** to reproduce the same setup.

---

## 🧠 Key Concepts

- **Virtual Network (VNet):** A private, isolated network in Azure for your resources.  
- **Subnet:** A smaller range inside the VNet where you place resources (like VMs).  
- **Network Security Group (NSG):** A built-in firewall that filters inbound and outbound traffic.  
- **Security Rule:** Defines what kind of traffic is allowed or denied.  
- **Rule Priority:** Lower numbers are evaluated first (e.g., 100 before 200).  
- **Association:** Linking an NSG to a subnet (or NIC) makes the rules take effect.

---

## ✅ Verification Steps

1. Run the PowerShell script in Cloud Shell.  
2. Open the **Azure Portal** → **Resource Group → LabLadder-RG**.  
3. Verify that:
   - A **Virtual Network** named `LabVNet` exists.
   - It contains a **Subnet** named `WebSubnet`.
   - A **Network Security Group** named `WebSubnet-NSG` exists.
   - Under **Inbound security rules**, the **Allow-HTTP** rule appears and allows TCP port 80.  
4. (Optional) Deploy a test VM later in `WebSubnet` to confirm HTTP connectivity.

---

## 🧩 Reflection
This mini-lab builds the foundation for **secure, segmented networks** in Azure.  
It demonstrates how to:
- Design address spaces for future scalability.  
- Enforce controlled access using **NSG rules**.  
- Link NSGs to subnets for consistent protection.  

These principles are used everywhere — from simple VMs to complex load-balanced architectures.
