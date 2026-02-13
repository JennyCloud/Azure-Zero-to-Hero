# 🌐 Azure Network Security Foundations: VNet & NSG

# 1️⃣ Azure Virtual Network (VNet)

## 🧠 What is a VNet?

An **Azure Virtual Network (VNet)** is a logically isolated network in Azure.

Think of it as:
> Your private network in the cloud — similar to a traditional on-premises network.

It allows Azure resources (VMs, databases, app services with private endpoints) to securely communicate with:
- Each other
- The internet
- On-premises networks (via VPN or ExpressRoute)

---

## 🔧 What VNet Provides

- IP address space (private IP ranges)
- Subnets (network segmentation)
- Routing control
- DNS configuration
- Secure connectivity options

---

## 🏗️ Core Components

### 🔹 Address Space
Defines the private IP range (e.g., 10.0.0.0/16)

### 🔹 Subnets
Logical divisions within a VNet (e.g., Web, App, DB tiers)

Segmentation improves:
- Security
- Organization
- Traffic control

---

# 2️⃣ Network Security Group (NSG)

## 🧠 What is an NSG?

A **Network Security Group (NSG)** is a filtering mechanism that controls inbound and outbound traffic.

It acts like a basic firewall at:
- Subnet level
- Network interface (NIC) level

---

## 🔐 How NSG Works

NSGs contain **security rules** that evaluate traffic based on:

- Source IP
- Destination IP
- Port number
- Protocol (TCP/UDP)
- Direction (Inbound/Outbound)

Each rule has:
- Priority number (lower = evaluated first)
- Allow or Deny action

---

## 🧱 Example

Rule:
- Allow inbound TCP 443 from Internet
- Deny all other inbound traffic

This means:
- HTTPS allowed
- Everything else blocked

---

## 🔄 Default Rules

Every NSG includes default rules such as:
- Allow VNet-to-VNet traffic
- Allow outbound Internet traffic
- Deny all other inbound traffic
