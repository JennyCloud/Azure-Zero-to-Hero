# 🧪 Azure Real-World Labs  
## Lab 01 – Hybrid Connectivity

*Simulating secure site-to-site VPN connectivity between Azure and an on-premises network.*

## 🎯 Purpose
Create a realistic hybrid network scenario that mirrors how Managed Service Providers (MSPs) link on-premises client infrastructure to Azure using IPsec VPN gateways.  
This lab demonstrates VNet design, gateway deployment, routing, and end-to-end troubleshooting.

## 🧱 Architecture Overview
| Component | Details |
|------------|----------|
| **Azure VNet** | `Azure-VNet` – 10.10.0.0/16 with `VMSubnet` and `GatewaySubnet` |
| **On-Prem VNet (Simulated)** | `OnPrem-VNet` – 192.168.1.0/24 with `OnPremSubnet` and `GatewaySubnet` |
| **Gateways** | Two route-based VPN gateways (SKU :`VpnGw1`) |
| **Connections** | VNet-to-VNet using shared key `Lab123!SharedKey` |
| **Verification** | Cross-ping between Azure VM and On-Prem VM through VPN tunnel |

## ⚙️ Key Steps
1. **Resource Group:** Created `HybridLab-RG`.  
2. **Networking:** Built VNets for Azure and On-Prem simulation.  
3. **Gateways:** Deployed static Standard Public IPs and VPN gateways.  
4. **Connections:** Established bidirectional VNet-to-VNet links.  
5. **Verification:** Deployed two Windows VMs and tested cross-ping successfully.  

## 🔍 Issues Encountered & Troubleshooting Record

| Issue | Root Cause | Resolution |
|-------|-------------|-------------|
| Public IP creation failed | Dynamic allocation not supported for VPN gateways | Re-created IP with `-Sku Standard -AllocationMethod Static` |
| Invalid subnet reference | Passed VNet ID instead of subnet object | Used `Get-AzVirtualNetworkSubnetConfig` to fetch subnet object |
| GatewaySubnet too small (/28) | Minimum size for zone-redundant gateway is /27 | Re-created as `192.168.1.224/27` |
| ConnectionStatus blank / Unknown | Only one connection object created | Added reverse connection and reset shared keys |
| Public IP quota exceeded | Free tier limit of 3 IPs per region | Deployed VMs with private IPs only and used Bastion |
| Bastion single-session limit | Developer SKU restriction | Tested sequentially (one VM at a time) |
| Ping failed (100 % loss) | ICMP blocked by firewall and NSG | Enabled ICMP via `netsh` and added NSG rule for `192.168.1.0/24` |

## ✅ Results
- **VPN Status:** Connected  
- **Ping Test:** Successful (Verified bi-directional connectivity)  
- **EgressBytesTransferred:** Non-zero values confirm live traffic  
- **Evidence:** All scripts and screenshots in `/scripts` and `/screenshots` 

## 🧠 Knowledge Highlights
| Skill Area | Demonstrated By |
|-------------|-----------------|
| Azure Networking & VPN | `create-vpn-gateway.ps1`, `create-site-to-site.ps1` |
| Infrastructure Automation | Parameterized PowerShell scripts |
| Troubleshooting & Diagnostics | Issue log and stepwise resolution documented above |
| Security & Governance | Minimal exposure design using private IP and NSG rules |

## 🧩 Professional Context
This scenario mirrors MSP operations when onboarding a client’s on-prem data center to Azure.  
It proves capability in network design, IP planning, VPN configuration, and live troubleshooting under subscription constraints.

## 🧭 Lessons Learned
- Always use **Static Standard** Public IPs for gateways.  
- `/27` is the minimum GatewaySubnet size.  
- Two connection objects (one per direction) ensure handshake success.  
- Bastion Developer is adequate for testing—connect sequentially.  
- Proper firewall and NSG rules are essential for cross-VNet traffic.  

## 📘 Reflection
This lab taught me how to translate Azure networking theory into real deployments, debug complex VPN issues using PowerShell, and document results systematically — skills directly relevant to MSP and Azure Administrator roles.
