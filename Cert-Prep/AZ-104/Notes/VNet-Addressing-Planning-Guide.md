# Azure Address Space Planning Guide  
## How to Plan the Address Space from the Beginning

A well-planned address space is the backbone of any stable Azure network. Good planning prevents future collisions, simplifies routing, supports hybrid connectivity, and keeps hub-and-spoke architectures from turning into a maze. The goal is to create a predictable, non-overlapping IP structure that can grow without painful redesigns.

---

## 1. Start by Choosing the Right Private IP Range

Azure VNets must use RFC1918 private ranges. The three options are:

- **10.0.0.0/8** — extremely large but commonly used on-premises, high collision risk.  
- **192.168.0.0/16** — small, often too restrictive for cloud growth.  
- **172.16.0.0/12** — a balanced middle ground with far fewer corporate conflicts.

For new cloud environments, **172.16.0.0/12** is often the safest starting point.

---

## 2. Allocate Large, Even Slices for VNets

A future hub-and-spoke topology works best when each VNet has a generous, non-overlapping block.

Example:
- Hub VNet → `172.16.0.0/16`
- Spoke A → `172.17.0.0/16`
- Spoke B → `172.18.0.0/16`
- Spoke C → `172.19.0.0/16`

This structure allows predictable subnetting and avoids painful expansions later.

---

## 3. Carve Deterministic Subnets Inside Each VNet

Subnets should follow a pattern that humans can understand at a glance.

**Hub VNet (`172.16.0.0/16`):**
- GatewaySubnet → `172.16.0.0/27`
- AzureFirewallSubnet → `172.16.0.32/26`
- BastionSubnet → `172.16.0.128/27`
- Shared Services → `172.16.1.0/24`
- DNS Resolver → `172.16.2.0/24`
- Monitoring → `172.16.3.0/24`

**Spoke VNet (`172.17.0.0/16`):**
- AppSubnet → `172.17.1.0/24`
- DBSubnet → `172.17.2.0/24`
- Private Endpoint Subnet → `172.17.10.0/24`
- Reserved for future workloads → `172.17.20.0/20`

Deterministic patterns reduce errors and improve troubleshooting.

---

## 4. Reserve Empty Space for Growth

Unused address ranges are not waste—they are strategic.

Leave gaps for:
- Future spokes  
- New tiers (Dev/Test/Prod)  
- AKS node pools  
- Future workloads requiring large subnets  
- Additional private endpoints  

Running out of space inside a VNet often forces a full migration.

---

## 5. Plan with VNet Peering in Mind

VNets **cannot overlap** when peered.

Design as if you will eventually have:
- Hub-and-spoke
- Mesh peering
- Multi-region VNets
- Hybrid connectivity to on-prem

Avoiding overlap from day one protects you from redesign later.

---

## 6. Reserve Space for Private Endpoints

Private Endpoints are small but *numerous*. They also cannot share subnets with other workloads.

Best practice:
- Create a **dedicated Private Endpoint subnet** in every VNet.
- Size it at least `/24`, or `/23` for heavy use.

PE subnets grow faster than most teams expect.

---

## Addressing Philosophy

A cloud network grows like a city.  
The best cities lay out their streets before the first building goes up.

Proper address planning is not optional—it's the foundation of every secure, scalable Azure environment.

