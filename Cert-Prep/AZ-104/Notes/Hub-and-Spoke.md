# What Is Hub-and-Spoke in Azure?

Hub-and-spoke is an Azure virtual network architecture that organizes networks like a wheel:

- **Hub** = the center  
- **Spokes** = the connected outer points  

It provides centralized security, connectivity, and isolation for workloads.

## 🟦 Hub = The Central VNet
The **hub VNet** is the main network that contains shared or critical services, such as:

- Azure Firewall / Palo Alto / FortiGate  
- VPN Gateway / ExpressRoute Gateway  
- Bastion  
- DNS forwarders  
- Monitoring tools  
- Identity services / domain controllers  
- Jump servers  

If the whole organization needs a service, it usually lives in the hub.

## 🟩 Spokes = The Workload VNets
Each **spoke VNet** hosts a specific application or environment:

- Spoke A: Web apps  
- Spoke B: Databases  
- Spoke C: Development  
- Spoke D: Analytics  

Spokes do not talk directly to each other.  
Traffic flows through the hub for control and security.

## 🔗 How Hub-and-Spoke Works
Each spoke connects to the hub using **VNet peering**.

Traffic pattern:

- Spoke A → Hub → Spoke B  
- Spoke C → Hub → Internet  
- Spoke D → Hub → On-premises  

The hub becomes the center for routing and inspection.

## 🔥 Why Enterprises Use Hub-and-Spoke

### Centralized Security
A single firewall in the hub protects all spokes.  
No need for multiple firewalls.

### Centralized Connectivity
Only the hub needs:
- ExpressRoute  
- VPN gateway  
- Bastion  

Spokes inherit this access.

### Isolation and Least Privilege
Spoke A cannot directly reach Spoke B unless explicitly allowed.  
Prevents cross-environment issues.

### Scalable by Design
Adding a new app is easy—just create a new spoke and peer it to the hub.

### Aligns with Zero Trust
All traffic goes through inspection, logging, and policies.

## 🧩 Simple Example

                +-------------------+
                |   On-premises     |
                +-------------------+
                          |
                      VPN/ER
                          |
           +-----------------------------+
           |             HUB             |
           |  Firewall | Bastion | DNS   |
           +-----------------------------+
            /             |             \
           /              |              \
  +-------------+  +-------------+  +-------------+
  |  Spoke A    |  |  Spoke B    |  |  Spoke C    |
  |  Web Tier   |  |   DB Tier   |  | Analytics   |
  +-------------+  +-------------+  +-------------+

## 🛠️ Where It Appears in AZ-104
Hub-and-spoke is relevant for:

- Implementing VNets  
- VNet peering  
- Azure Firewall integration  
- Securing workloads  
- Enterprise landing zone design  

It’s the most common enterprise network pattern in Azure.
