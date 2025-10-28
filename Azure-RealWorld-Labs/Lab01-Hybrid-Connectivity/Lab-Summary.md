# Lab 01 – Hybrid Connectivity
**Author:** Jenny Wang (@JennyCloud)  
**Completed:** October 27, 2025  

---

## 🎯 Purpose
Simulate a secure hybrid network connecting an on-premises environment to Azure using IPsec VPN gateways and VNets.  
This lab demonstrates core skills used by MSPs to link customer infrastructure with Azure.

---

## 🧱 Architecture Overview
| Component | Details |
|------------|----------|
| **Azure VNet** | `Azure-VNet` – 10.10.0.0/16 with `VMSubnet` and `GatewaySubnet` |
| **On-Prem VNet (Simulated)** | `OnPrem-VNet` – 192.168.1.0/24 with `OnPremSubnet` and `GatewaySubnet` |
| **Gateways** | Two Route-based VPN gateways (Sku: `VpnGw1`) |
| **Connections** | VNet-to-VNet using shared key `"Lab123!SharedKey"` |
| **Verification** | Cross-ping between Azure VM and On-Prem VM through VPN tunnel |

---

## 🧩 Tools Used
- **Azure Portal**  
- **Azure PowerShell (Cloud Shell)**  
- **Azure Bastion (Developer SKU)**  
- **Windows Server 2022 Datacenter (smalldisk image)**  

---

## ⚙️ Key Steps
1. Created Resource Group `HybridLab-RG`.  
2. Built VNets for Azure and simulated On-Prem networks.  
3. Deployed Static Public IPs and created both VPN gateways.  
4. Established bidirectional VNet-to-VNet connections.  
5. Verified tunnel status and deployed two Windows Server test VMs.  
6. Confirmed encrypted communication through successful ICMP ping.  

---

## 🔍 Issues Encountered and Resolutions

| Issue | Cause | Resolution |
|-------|--------|-------------|
| **Public IP creation failed (Dynamic allocation)** | VPN Gateways require Static IPs. | Re-created with `-Sku Standard -AllocationMethod Static`. |
| **Invalid subnet reference error** | Passed VNet ID instead of subnet object. | Used `Get-AzVirtualNetworkSubnetConfig` before gateway creation. |
| **GatewaySubnet too small (/28)** | Minimum size for gateway is `/27`. | Re-created subnet `192.168.1.224/27`. |
| **ConnectionStatus blank / Unknown** | Only one connection object existed. | Added reverse connection and reset keys with `Set-AzVirtualNetworkGatewayConnectionSharedKey`. |
| **Public IP quota exceeded** | Free tier allows max 3 IPs per region. | Deployed VMs with private IPs only; accessed via Bastion. |
| **Bastion Developer single-session limit** | SKU restriction. | Tested sequentially: one VM at a time. |
| **Ping failed (100% loss)** | ICMP blocked by Windows Firewall and NSG. | Enabled ICMP in OS and added NSG rule allowing traffic from `192.168.1.0/24`. |

---

## ✅ Results
- **Connection Status:** Connected  
- **Ping Test:** Success (OnPremTestVM → AzureTestVM)  
- **EgressBytesTransferred:** Greater than 0, confirming tunnel traffic  
- **All evidence stored under:**  
  `Azure-RealWorld-Labs/Lab01-Hybrid-Connectivity/screenshots/`

---

## 🧠 Lessons Learned
- Always use **Static Standard** IPs for gateways.  
- `GatewaySubnet` must be `/27` or larger.  
- Two connection objects (one each direction) ensure handshake success.  
- **Bastion Developer** is fine for testing—sequential use only.  
- Firewall + NSG configuration is essential for inter-VNet ICMP traffic.  

---

## 🚀 Next Steps
- Automate this lab with **ARM template** or **Bicep**.  
- Add **Azure Monitor** diagnostic logs for VPN insights.  
- Extend lab with **ExpressRoute** or **VNet Peering** comparison.  

---

*End of Lab Summary – Hybrid Connectivity*
