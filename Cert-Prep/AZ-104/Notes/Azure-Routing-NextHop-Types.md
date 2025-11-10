# 🌐 Azure Routing – Next Hop Types Explained

**Topic:** Azure Route Tables (User-Defined Routes)

---

## 📘 Overview

In Azure networking, **route tables (UDRs)** control how traffic moves between subnets, virtual networks, gateways, and the internet.  
When you create a custom route, you define two key things:

- **Destination prefix** – where the traffic is going (for example `10.0.0.0/16`)
- **Next hop type** – where the traffic should go next

The **next hop type** tells Azure *what kind of target* will handle the traffic, and sometimes requires a **specific IP address**.

---

## 🧭 Next Hop Types and Their Meanings

| Next Hop Type | Description | IP Address Required? | Typical Use Case |
|:--|:--|:--:|:--|
| **Virtual network** | Traffic stays within the same VNet. This is the system default route. | ❌ | Communication between subnets |
| **Virtual network gateway** | Sends traffic to a VPN or ExpressRoute gateway managed by Azure. | ❌ | Routing traffic to on-premises networks |
| **Internet** | Sends traffic directly to the internet (bypassing gateways). | ❌ | Allowing outbound internet access |
| **Virtual appliance** | Sends traffic to a specific virtual machine or firewall acting as a router. | ✅ | Network firewall or proxy inside a subnet |
| **None** | Drops packets instead of forwarding them. | ❌ | Used for isolation or testing blackhole routes |

---

## 💡 Key Concept

Only the **Virtual Appliance** hop type requires a **next hop IP address** because Azure needs to know exactly which device to send packets to.  
All other hop types are **system-managed** — Azure knows their routes automatically.

Think of it like giving directions:
- *“Go to the city”* → Internet / Gateway / VNet (Azure knows the way)
- *“Go to this specific building”* → Virtual appliance (you provide the address)

---

## 🧩 Example Questions

### 1️⃣ Virtual Appliance Example

**Scenario:**  
You have an Azure route table named **RT1**.  
You must add a route that specifies a *next hop IP address.*

**Which next hop type should you select?**  
- Internet  
- Virtual network gateway  
- Virtual network  
- ✅ **Virtual appliance**

**Explanation:**  
Only the *Virtual appliance* route type allows specifying a next hop IP.  
This IP usually belongs to a firewall or router VM (NVA) that inspects or redirects traffic.

---

### 2️⃣ Virtual Appliance Firewall Scenario

**Scenario:**  
- VNet1 has SubnetA and SubnetB.  
- VM **FW1** in SubnetA is a network firewall.  
- You want all traffic from SubnetB to the internet to go through FW1 first.

**Solution:**  
Create a custom route in SubnetB’s route table:  
- **Destination:** `0.0.0.0/0`  
- **Next hop type:** `Virtual appliance`  
- **Next hop IP:** Private IP of **FW1**

**Explanation:**  
You’re manually steering traffic through a specific device, so you must specify its IP.  

---

### 3️⃣ Virtual Network Gateway Scenario

**Scenario:**  
You connect your on-premises network to Azure via a VPN using a **Virtual Network Gateway (GW1)**.  
You need SubnetX to send traffic to the on-prem network (10.0.0.0/16) through the VPN.

**Which next hop type should you select?**  
✅ **Virtual network gateway**

**Explanation:**  
Azure already knows where the VPN gateway is.  
You don’t specify an IP — the system handles routing automatically.

---

## 🧠 Summary of the Pattern

| Route Scenario | Correct Next Hop Type | Reason |
|:--|:--|:--|
| Send traffic to an internal firewall or NVA | **Virtual appliance** | You must specify the device’s IP |
| Send traffic to on-premises via VPN/ExpressRoute | **Virtual network gateway** | Azure knows the gateway automatically |
| Send traffic within same VNet | **Virtual network** | Default system route |
| Send traffic out to internet | **Internet** | Azure routes to public endpoint |
| Block traffic intentionally | **None** | Drops packets |

---

## 🧩 Memory Trick

> **“Appliance = Address.”**  
If you must type an IP, it’s a Virtual Appliance route.  
Everything else is handled by Azure’s invisible routing fabric.

---

## 🧱 Real-World Tip

In production, use **Virtual appliance** routes when inserting firewalls (like Azure Firewall, Fortinet, or Palo Alto)  
and **Virtual network gateway** routes for hybrid connectivity (VPN, ExpressRoute).
